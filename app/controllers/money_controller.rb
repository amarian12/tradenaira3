class MoneyController < ApplicationController


  def req
    if current_user.nil?
      flash[:notice] = "You must be loggedin, before continue."
      redirect_to root_path
    end
  end


  def req_success
  end
  def commission
  end

  def request_money

    if params[:member]
      member = current_user
      amount = BigDecimal.new(params[:member][:amount_to_send])
      account_id =  params[:member][:currency]
      email =  params[:member][:email]
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
      else
         errors << "Receipent does not exists in the system."
      end

      success = false;

      MoneyExchange.where(
        sent_by_id: member.id,
        sent_to_id: sent_to_id,
        sent_on_email: email,
        request_type: 1,
        status: 0).destroy_all

      me = MoneyExchange.new(
        sent_by_id: member.id,
        sent_to_id: sent_to_id, 
        sent_on_email: email,
        account_id: account.id,
        request_type: 1,
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

      success = false;

      MoneyExchange.where(
        sent_by_id: member.id,
        sent_to_id: sent_to_id,
        sent_on_email: email,
        request_type: 0,
        status: 0).destroy_all

      me = MoneyExchange.new(
        sent_by_id: member.id,
        sent_to_id: sent_to_id, 
        sent_on_email: email,
        account_id: account.id,
        request_type: 0,
        amount: amount,
        status: 0)
      if me.save
        success = true
      end

      two_fetor = { is_active: current_user.two_factors.activated.first }

  		resp = { msg: "", success: success, 
        acode: "send", errors: errors, 
        mei: me.id,
        two_fetor: two_fetor }

  		render json: resp

  	end
  end
end
