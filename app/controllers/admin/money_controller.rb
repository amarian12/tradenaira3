module Admin
  	class MoneyController < BaseController

	  def money_sent
	  	status = params[:status] || 1
	  	@me = MoneyExchange.where(status: status)
	  	.where(request_type: :send_meney)
	  	.order(created_at: :desc)
	  	@request_type = "Send Money"
	  end

	  def money_request
	  	status = params[:status] || 1
	  	@me = MoneyExchange.where(status: status)
	  	.where(request_type: :request_meney)
	  	.order(created_at: :desc)
	  	@request_type = "Request Money"
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
	  		
	  		if @me.update_success
	  			if me.save
		  			flash[:notice] = "Amount transfer successfully approved"
		  			redirect_to :back
		  			return false
	  			end
	  		end
  		when "declined"
  			@me.status = "declined"
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
