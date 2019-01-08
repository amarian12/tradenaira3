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


	  def edit
	  	success = false
	  	model 	= params[:model]
	  	id 		= params[:id]
	  	field 	= params[:field]
	  	value	= params[:value]
	  	msg 	= ""

	  	clobject = model.capitalize.constantize.find_by_id(id)
	  	if clobject
	  		clobject.send("#{field}=",value)
	  		if clobject.save
	  			success = true
	  		else
	  			msg = clobject.errors.full_messages
	  		end
	  	else
	  		msg = "Object not found"
	  	end

	  	resp = { success: success, msg: msg }
	  	respond_to do |formate|
	  		formate.json{ render json: resp }
	  	end
	  	
	  end

	  def escrow
	  	status = params[:status] || ""

	  	if params[:status].nil?
	  		@escrows = Escrow.where("status > 0")	
	  	else
	  		@escrows = Escrow.where(status: status)
	  	end
	  	@escrows = @escrows.order(created_at: :desc ).page(params[:page]).per(12)

	  	@status = status

	  end

	  def manage
	  	tn = params[:tn]
	  	if tn == "escrow"
	  		return manage_escrow
	  	end
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
		  			flash[:notice] = "Amount approved successfully"
		  			redirect_to :back
		  			return false
	  			end
	  		end
  		when "declined"
  			@me.status = "declined"
  			@me.decline_transuction
  			if @me.save
	  			flash[:notice] = "Declined successfully!"
	  			UserMailer.admin_decline(@me,@me.sender).deliver
	  			redirect_to :back
	  			return false
	  		end
	  	when "won_sender"
	  		@me.status = "won_sender"
	  		@me.save
	  		@me.approve_transuction
	  		flash[:notice] = "Success!"
	  	when "won_receiver"	
	  		@me.status = "won_receiver"
	  		@me.save
	  		@me.approve_transuction
	  		flash[:notice] = "Success!"
	  	end


	  	if @me.trans_errors
	  		if @me.trans_errors.class.to_s == "Array"
	  			flash[:alert] = @me.trans_errors.join(", ")
	  		else
	  			flash[:alert] = @me.trans_errors
	  		end
	  		
	  	end
	  	redirect_to :back
	  end

	  def resend_instructions
	  	@me = MoneyExchange.find_by_id(params[:id])
	  	UserMailer.signup_request(@me,@me.sender).deliver
	  	flash[:notice] = "Email sent success"
	  	redirect_to :back
	  end



	  def finances
	  	 @member = 
	  	 @account_versions = AccountVersion.where("fee > 0")
	  	 unless params[:currency].nil?
	  	  @account_versions = @account_versions.where(currency: params[:currency] )	
	  	 end

	  	 if params[:sd] && params[:ed]

	  	 	sd = Date.strptime(params[:sd], '%m-%d-%Y').to_datetime
	  	 	ed = Date.strptime(params[:ed], '%m-%d-%Y').to_datetime

	  	 	@account_versions = @account_versions
	  	 	.where("created_at >= ? AND created_at <= ?",sd,ed)	
	  	 	
	  	 end
	  	 @account_versions = @account_versions.order(:id)
	  	 .reverse_order.page params[:page]
	  end

	  def manage_escrow
	  	escrow = Escrow.find_by_id(params[:id])
	  	doaction = params[:doaction]
	  	case doaction
	  	when "approve"
	  		if escrow.is_all_paid?
	  			escrow.status = 4
	  			escrow.save
	  			flash[:notice] = "Approved successfully"
	  		else
	  			flash[:notice] = "Cant approve this stage."
	  		end
	  	when "decline"
	  		escrow.status = 5
	  		escrow.save
	  		flash[:notice] = "Declined successfully"
	  	end
	  	redirect_to :back
	  end
	end
end
