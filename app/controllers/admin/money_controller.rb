module Admin
  	class MoneyController < BaseController

	  def money_sent
	  	status = params[:status] || ""
	  	if params[:status].nil?
	  		@me = MoneyExchange.where("status > 0")	
	  	else
	  		@me = MoneyExchange.where(status: MoneyExchange::STATUS_CODES[status.to_sym])
	  	end

	  	@me = @me
	  	.where(request_type: 0)
	  	.order(created_at: :desc)
	  	@request_type = "Send Money"
	  	@status = status
	  end

	  def money_request
	  	 status = params[:status] || ""
	  	if params[:status].nil?
	  		@me = MoneyExchange.where("status > 0")	
	  	else
	  		@me = MoneyExchange.where(status: MoneyExchange::STATUS_CODES[status.to_sym])
	  	end

	  	@me = @me
	  	.where(request_type: 1)
	  	.order(created_at: :desc)
	  	@request_type = "Receive Money request"
	  	@status = status

	  end

	  def manage
	  	@me = MoneyExchange.find_by_id(params[:id])
	  	me = @me
	  	if @me.nil?
	  		flash[:alert] = "Incomplete request."
	  		redirect_to :back
	  		return false
	  	end
	  	sender = @me.sender
	  	recceiver = @me.receiver 
	  	if sender.nil? || recceiver.nil?
	  		flash[:alert] = "Both users must exists in the system"
	  		redirect_to :back
	  		return false
	  	end

	  	doaction = params[:doaction]
	  	case doaction
	  	when "approve"
	  		me.status = 2
	  		@me.approve_transuction
	  		msgnoti = "Money request accepted by admin"
	  		SrNotofication.create(
	          member_id: me.sender.id,
	          msg: msgnoti,
	          status: false)

	  		SrNotofication.create(
	          member_id: me.receiver.id,
	          msg: msgnoti,
	          status: false)

	  		if @me.update_success
	  			if me.save
		  			flash[:notice] = "Amount transfer successfully approved"
		  			redirect_to :back
		  			return false
	  			end
	  		end
  		when "declined"
  			@me.status = "declined"
  			@me.decline_transuction
  			msgnoti = "Money request declined by admin"
	  		SrNotofication.create(
	          member_id: @me.sender.id,
	          msg: msgnoti,
	          status: false)
	  		SrNotofication.create(
	          member_id: @me.receiver.id,
	          msg: msgnoti,
	          status: false)

  			if @me.save
	  			flash[:notice] = "Request declined successfully!"
	  			UserMailer.admin_decline(@me,@me.sender).deliver
	  			redirect_to :back
	  			return false
	  		end
	  	end


	  	if @me.trans_errors
	  		flash[:notice] = @me.trans_errors.join(", ")
	  	end
	  	redirect_to :back
	  end

	  def resend_instructions
	  	@me = MoneyExchange.find_by_id(params[:id])
	  	UserMailer.signup_request(@me,@me.sender).deliver
	  	flash[:notice] = "Email sent success"
	  	redirect_to :back
	  end

	end
end
