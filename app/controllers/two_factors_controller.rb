class TwoFactorsController < ApplicationController
  before_action :auth_member!
  before_action :two_factor_required!

  def show
    respond_to do |format|
      if require_send_sms_verify_code?
        send_sms_verify_code
        format.any { render status: :ok, nothing: true }
      elsif two_factor_failed_locked?
        format.any { render status: :locked, inline: "<%= show_simple_captcha %>" }
      else
        format.any { render status: :ok, nothing: true }
      end
    end
  end

  def index
     
    unless params["respas"].nil?
      if params["respas"] == "noheader"
        render "index", layout: false
        return false
      end
    end
  end

  def validatetrans
    sucess = false
    errors = ""
    msg = ""
    mei = params[:two_factor][:mei] 
    acode = params[:two_factor][:acode]
    capreq = false
    if params[:acode] == "escrow"
      process_escrow_two_factor
      return false
    end

    me = MoneyExchange.find_by_id(mei)

    unless me.nil?
      account = me.account
      receiver_id = me.receiver.nil? ? 0 : me.receiver.id
      if two_factor_auth_verified?
        me.status = 1
        if me.save
          sucess = true

          #Request money
          if acode == "request"
            msg = "Your money has been requested successfully. Your wallet will reflect once user approved your transaction"
            if me.receiver.nil?
             UserMailer.signup_request(me,current_user).deliver 
            else
              msgnoti = "#{current_user.email} requested you some money!"
              SrNotofication.create(
              member_id: receiver_id,
              msg: msgnoti,
              link_page: "accept_decline",
              status: false)
             UserMailer.money_request(me,current_user).deliver
            end
          #Request money  
          elsif acode == "send"
            account.lock_funds(me.amount, reason: Account::MONEYSENT, ref: self)
            msg = "Your money has been sent successfully. Your wallet will reflect once we have approved your transaction"  
            #send notification
            msgnoti = "#{current_user.email} sent you some money, 
            currently its waiting for admin approval."
            SrNotofication.create(
              member_id: receiver_id,
              msg: msgnoti,
              link_page: "accept_decline",
              status: false)
            UserMailer.admin_approval(me).deliver
            if me.receiver.nil?
              UserMailer.signup_request(me,current_user).deliver
            end
          
          #Escrow Money
          elsif acode == "escrow"
            account.lock_funds(me.amount, reason: Account::MONEYESCROW, ref: self)
            msg = "Your money has been escrow successfully. Same fund is locked from your wallet and will reflect as per admin actions."  
            #send notification
            msgnoti = "#{current_user.email} escrowed some money with you, 
            currently its waiting for admin approval."
            SrNotofication.create(
              member_id: receiver_id,
              msg: msgnoti,
              link_page: "escrow",
              status: false)
            UserMailer.admin_approval(me).deliver
            if me.receiver.nil?
              UserMailer.signup_request(me,current_user).deliver
            end
           

          end

        end
      else
        sucess = false
        if two_factor_failed_locked?
          capreq = true
          errors = "Please enter the code shown in the picture."
        else
          errors = "Two factor verification code error, please re-enter."
        end
        
      end
    end

    resp = { success: sucess, errors: errors, captach: capreq, msg: msg  }
    render json: resp
  end

  def update
    if two_factor_auth_verified?
      unlock_two_factor!

      redirect_to session.delete(:return_to) || settings_path
    else
      redirect_to two_factors_path, alert: t('.alert')
    end
  end

  private

  def two_factor_required!
    @two_factor ||= two_factor_by_type || first_available_two_factor

    if @two_factor.nil?
      redirect_to settings_path, alert: t('two_factors.auth.please_active_two_factor')
    end
  end

  def two_factor_by_type
    current_user.two_factors.activated.by_type(params[:id])
  end

  def first_available_two_factor
    current_user.two_factors.activated.first
  end

  def require_send_sms_verify_code?
    @two_factor.is_a?(TwoFactor::Sms) && params[:refresh]
  end

  def send_sms_verify_code
    @two_factor.refresh!
    @two_factor.send_otp
  end

  def process_escrow_two_factor
    escrow = Escrow.find_by_id(params[:eid])
    msg = ""
    if two_factor_auth_verified?
      captach = true
      if escrow 
        escrow.status = 1
        escrow.save
        success = true
        errors = false
      else
        success = false
        if two_factor_failed_locked?
          capreq = true
          errors = "Please enter the code shown in the picture."
        else
          errors = "Two factor verification code error, please re-enter."
        end
      end
    else
      captach = false
      success = false
      errors = "Two factor verification code error, please re-enter."
    end
    
    

    resp = { success: success, errors: errors, captach: capreq, msg: msg  }
    render json: resp
    
  end

end
