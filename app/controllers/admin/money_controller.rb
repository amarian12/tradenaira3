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

	  end

	  def resend_instructions
	  	@me = MoneyExchange.find_by_id(params[:id])
	  	UserMailer.signup_request(@me,@me.sender).deliver
	  	flash[:notice] = "Email sent success"
	  	redirect_to :back
	  end

	end
end
