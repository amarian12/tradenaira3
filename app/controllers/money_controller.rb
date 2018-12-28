class MoneyController < ApplicationController
before_action :two_factor_required!, only: [:two_factor, :processm]
before_action :auth_member!, only: [:two_factor, :processm, :escrow_create]

  def req
    if current_user.nil?
      flash[:notice] = "You must be loggedin, before continue."
      redirect_to root_path
    end
  end

  def new
    @identity = Identity.new
  end
  
  def req_success
  end
  def commission
  end

  def two_factor
   unless validate_request
    return false
   end

   if @status == "decline"
      if @me.decline_request
        msgnoti = "Your money request was declined by #{@me.receiver.email}"
        SrNotofication.create(
          member_id: @me.sender.id,
          msg: msgnoti,
          link_page: "accept_decline",
          status: false)

          flash[:notice] = "Request declined successfully!"
      else
          errors = @me.trans_errors 
          flash[:alert] = errors
      end
      redirect_to :back
      return false
   end
    @url = process_request_path(@me.id,@status)

    render "two_factor", layout: "application"

  end

  def escrow
   @title    = "Nigeria’s most Trusted Escrow Platform. Manage all your transactions in one place!"
   @descrip  = "TradeNAIRA hosts Nigeria’s most trusted Escrow Service. Create secure online payments 
                and transactions with Nigerian businesses and individuals using our Escrow Platform."
   @keyword  = "escrow, online transactions, safe online transactions, escrow services, escrow service"
    if current_user.nil?
      return false
    end
    roles         = [ "buyer", "seller", "broker"  ]
    transaction  = MetaCategory.find_by_title("Escrow transaction")
    accounts = []
     current_user.accounts.map{|a| 
      accounts << { id: a.id, balance: a.balance, currency: a.currency } unless a.currency.nil?
     }
    meta = { 
      roles: roles,
      transactions: (transaction.meta_contents unless transaction.nil?),
      accounts: accounts
      }
    resp = { success: true, meta: meta, user: current_user }
    respond_to do |formate|
      formate.json{ render json: resp }
      formate.html{  }
    end
  end

  def escrow_create
    success = false
    errors  = false
    escrow = Escrow.new
    user = current_user
    errors = []
    msg = 0

    escrow.tn_type            = params[:type]
    escrow.tn_role            = params[:role]
    escrow.buyer_phone        = params[:buyer_phone]
    escrow.seller_phone       = params[:seller_phone]
    escrow.tn_currency        = params[:currency]
    escrow.tn_amount          = params[:amount]
    escrow.item_name          = params[:item_name]
    escrow.shipping_currency  = params[:shipping_currency]
    escrow.shipping_amount    = params[:shipping_amount]
    escrow.fee_payer          = params[:fee_payer]
    escrow.inspection_length  = params[:inspection_length]
    escrow.descriptions       = params[:descriptions]
    escrow.member_id          = current_user.id
    escrow.status             = 0
    

    if escrow.tn_role == "broker"
      escrow.amount_payer       = params[:amount_payer]
      escrow.buyer_email        = params[:buyer_email]
      escrow.seller_email       = params[:seller_email]
    elsif escrow.tn_role == "seller" 
      escrow.amount_payer       = "buyer"
      escrow.buyer_email        = params[:buyer_email]
      escrow.seller_email       = current_user.email 
    elsif escrow.tn_role == "buyer" 
      escrow.amount_payer       = "seller"
      escrow.buyer_email        = current_user.email
      escrow.seller_email       = params[:seller_email]  
    end

    receipent = Member.find_by_email(params[:email])
    unless receipent.nil?
      escrow.recepient_id     = receipent.id
    end

    if escrow.is_user_amount_payer? user
      unless escrow.has_tn_amount? user
        msg = "You do not have sufficient balance to process this request!"
        errors << msg

      end
    end

    current_user.escrows.where(status: 0 ).destroy_all
    two_fetor = ""
    unless errors.present?
      if escrow.save
        success = true
        sms     = current_user.two_factors.where(type: "TwoFactor::Sms").last
        google  = current_user.two_factors.where(type: "TwoFactor::App").last
        two_fetor = { 
            is_active: current_user.two_factors.activated.first, 
            google_app: (google.nil? ? false : true),
            sms:      (sms.nil? ? false : true)
          }
      else
        errors = escrow.errors.messages
      end
    end
      
    resp = { 
      msg: msg, 
      success: success, 
      errors: errors, 
      escrow_id: escrow.id,
      two_fetor: two_fetor 
    }

    render json: resp

  end

  def quick_exchange
    
    
    @title = "Quick exchange money"
    @descrip = "Quick exchange money to Nigeria"
  end

  def processm
    unless validate_request
      return false
    end

    if two_factor_auth_verified?
      if @status == "accept"
        if @me.accept_request
          msgnoti = "Your money request was accepted by #{@me.receiver.email} and waiting
          for admin approval"
          SrNotofication.create(
          member_id: @me.sender.id,
          msg: msgnoti,
          link_page: "accept_decline",
          status: false)
          flash[:notice] = "Amount sent is in process and waiting for admin approval!"
        else
          errors = @me.trans_errors 
          flash[:alert] = errors
        end

      elsif @status == "decline"
        #already processed
      end
      redirect_to send_money_path
    else

      flash[:alert] = "Two factor verification code error, please re-enter."
      redirect_to :back
    end

  end


  def sendm
    @member = current_user
    @requests = MoneyExchange.where(
      sent_on_email: @member.email, 
      request_type: MoneyExchange::REQTYPES[:request_meney], 
      status: MoneyExchange::STATUS_CODES[:active]).order(created_at: :desc) 

    render "send"
    
  end

  def escrow_manage
    escrow = Escrow.find_by_id(params[:id])
    user = current_user
    errors = []
    request_for = params[:request_for]
    success = false
    msg = ""

    if request_for == "accept"
      if escrow.is_user_amount_payer? user
        if escrow.has_tn_amount? user
          if escrow.approve_by_buyer(user)
            escrow.status = 2
            escrow.save(validate: false)
            success = true
            msg = "Approved success"
          end
        else
          errors << "You don't have sufficient balance to process this request!"
        end
      else
        errors << "You are not authorised to access this page!"
      end
    else
    request_for == "decline"  
      if escrow.status == "1"
        escrow.decline_by_buyer(user)
        escrow.status = 6
        escrow.save
        msg = "declined success"
        success = true
      else
        success = false
        msg = "Please review following errors!"
        errors << "can't declin on this stage"
      end
      
    end

    resp = { success: success, msg: msg, errors: errors }

    respond_to do |formate|
      formate.json{ render json: resp }
    end
      
  end

  def request_money

    if params[:member]
      member = current_user
      amount = BigDecimal.new(params[:member][:amount_to_send])
      account_id =  params[:member][:currency]
      email =  params[:member][:email]
      note  = params[:member][:notes]
      errors = []
      email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      unless email.match(email_regex)
        errors << "Receipent email is not valid!"
      end
      if(email == member.email)
        errors << "You can not send money to yourself."
      end

      account = member.accounts.find_by_id(account_id)

      # if amount > account.balance
      #   errors << "you can not send more than available balance."
      # end

      if amount <= 0
        errors << "You must fill valid amount."
      end
      sent_to_id = 0

      receiver = Member.find_by_email(email)
      
      unless receiver.nil?
        sent_to_id = receiver.id
      end

      success = false;

      MoneyExchange.where(
        sent_by_id: member.id,
        sent_to_id: sent_to_id,
        sent_on_email: email,
        note: note,
        request_type: 1,
        status: 0).destroy_all

      me = MoneyExchange.new(
        sent_by_id: member.id,
        sent_to_id: sent_to_id, 
        sent_on_email: email,
        account_id: account.id,
        request_type: 1,
        note: note,
        amount: amount,
        status: 0)
      
      unless errors.present?
        if me.save
          success = true
        end
      end
      

      two_fetor = { is_active: current_user.two_factors.activated.first }

      resp = { msg: "", success: success, 
        acode: "request", errors: errors, 
        mei: me.id,
        two_fetor: two_fetor }

      render json: resp

    end
    
  end

  def send_money
  	if params[:member]
      member = current_user
      amount = BigDecimal.new(params[:member][:amount_to_send])
      account_id =  params[:member][:currency]
      email =  params[:member][:email]
      note  = params[:member][:notes]
      errors = []
      email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      unless email.match(email_regex)
        errors << "Receipent email is not valid!"
      end
      if(email == member.email)
        errors << "You can not send money to yourself."
      end

      account = member.accounts.find_by_id(account_id)

      if amount > account.balance
        errors << "you can not send more than available balance."
      end

      if amount <= 0
        errors << "You must fill valid amount."
      end
      sent_to_id = 0

      receiver = Member.find_by_id(email)
      unless receiver.nil?
        sent_to_id = receiver.id
      end

      success = false
      me_id = 0

      MoneyExchange.where(
        sent_by_id: member.id,
        sent_to_id: sent_to_id,
        sent_on_email: email,
        request_type: 0,
        note: note,
        status: 0).destroy_all


      if errors.present?
        success = false;
      else
        me = MoneyExchange.new(
        sent_by_id: member.id,
        sent_to_id: sent_to_id, 
        sent_on_email: email,
        account_id: account.id,
        request_type: 0,
        note: note,
        amount: amount,
        status: 0)
        if me.save
          success = true
        end
        me_id = me.id
      end

      

      

      two_fetor = { is_active: current_user.two_factors.activated.first }

  		resp = { msg: "", success: success, 
        acode: "send", errors: errors, 
        mei: me_id,
        two_fetor: two_fetor }

  		render json: resp

  	end
  end

  def accept_decline_money
    if current_user.nil?
        flash[:notice] = "You must be loggedin, before continue."
        redirect_to root_path
        return false
    end

    @title    = "Accept Decline Money"
    @descrip  = "Accept Decline Money" 
    @member = current_user
    
    @requests = MoneyExchange.where(
      sent_on_email: @member.email, 
      request_type: MoneyExchange::REQTYPES[:request_meney], 
      status: MoneyExchange::STATUS_CODES[:active]).order(created_at: :desc) 

     @send_money = MoneyExchange.where(
      sent_by_id: @member.id, 
      request_type: MoneyExchange::REQTYPES[:send_money])
     .where("status > 0")
      .order(created_at: :desc) 

    @requests_sent_you =  MoneyExchange.where(
      sent_by_id: @member.id, 
      request_type: MoneyExchange::REQTYPES[:request_meney])
     .where("status > 0")
     .order(created_at: :desc)  

    @escrows = Escrow.where("(member_id = ? OR seller_email = ? OR buyer_email = ?) AND status > 0",
      current_user.id, current_user.email, current_user.email)
      .order(updated_at: :desc)
      .order(status: :asc)   
    

  end

 
  
  private

  def validate_request
    @status = params[:status]
    success = false
    errors = false
    @member = current_user
    @me = MoneyExchange.find_by_id(params[:id])

    unless @me.receiver == @member
      flash[:alert] = "You are not authorised to process this request!" 
      redirect_to :back
      return false
    end
    
    if @status != "decline"
      unless @me.receiver_account.balance >= @me.amount
        flash[:alert] = "You do not have sufficient balance to process this request!" 
        redirect_to :back
        return false
      end
    end


    return true
  end

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




end
