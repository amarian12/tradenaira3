class MoneyController < ApplicationController
  def req
  end
  def req_success
  end
  def commission
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

      me = MoneyExchange.new(
        sent_by_id: member.id,
        sent_to_id: sent_to_id, 
        amount: amount,
        status: 0)

  		resp = { msg: "", success: true, errors: errors, status: me.status }

  		render json: resp

  	end
  end
end
