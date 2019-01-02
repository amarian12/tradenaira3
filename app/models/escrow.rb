class Escrow < ActiveRecord::Base
	belongs_to :member
	belongs_to :transaction_type,  class_name: "MetaContent", foreign_key: "tn_type" 

	validates :tn_type, :tn_role, 
	:tn_currency, :tn_amount, :item_name, :shipping_currency, 
	:amount_payer, :fee_payer, :shipping_amount,
	:inspection_length, :descriptions, :member_id, :status, presence: true

	validates :seller_email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :is_buyer?
	validates :buyer_email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :is_seller? 
	validates :buyer_email, :seller_email, format: { with: URI::MailTo::EMAIL_REGEXP }, 
	if: :is_broker? 


	MONEYDB = :money_debited
	MONEYCR = :money_credited
	MONEYRB = :money_rollback	

	MONEYSHDB = :shipping_money_debited
	MONEYSHCR = :shipping_money_credited
	MONEYSHRB = :shipping_money_rollback

	FEE = 2.0 #% amount

	def get_status
		st = [	
			"pending", 			#0
			"active",			#1
			"approved_buyer",	#2
			"declined_buyer",	#3
			"approved_admin",	#4
			"declined_admin",	#5
			"closed"			#6
		 ]
		 st[status.to_i]
	end


	validates :tn_amount, numericality: { only_integer: true, greater_than_or_equal_to: 200 }

	after_save :notify_users

	def inspection_period
		(inspection_length.gsub("days","").gsub("day","").strip.chomp).to_i
	end

	def closing_date
		created_at+inspection_period.days
	end

	def remaining_days
		(closing_date.to_datetime - DateTime.now ).to_i
	end

	def seller
		Member.find_by_email(seller_email)
	end

	def buyer
		Member.find_by_email(buyer_email)
	end

	def broker
		self.member if self.tn_role == "broker"
	end

	def editable_option field
		tag = "<a href='javascript:void(0)' class='selfeditobject'"
		tag += "data-field='#{field}'"
		tag += "data-id='#{id}'"
		tag += "data-path='/admin/money/edit'"
		tag += "data-model='escrow'"
		 
		tag += " >"
		tag += send(field.to_sym)
		tag += "</a>"
		tag

	end

	def user_role email
		return "seller" if (self.seller_email == email)
		return "buyer"  if (self.buyer_email == email)
		return "broker" if (self.tn_role == "broker" &&  self.member.email == email)
	end

	def is_user_amount_payer? user
		if tn_role == "seller" || tn_role == "buyer"
			return true if buyer_email == user.email
		elsif tn_role == "broker"
			return true if (amount_payer == user_role(user.email) && amount_payer != "")	
		end
		return false
	end

	def is_user_fee_payer user
		return true if fee_payer == user_role(user.email)
		return false
	end

	def has_tn_amount? user
		tncurrency = Currency.where(code: tn_currency).last
		shippingcurrency = Currency.where(code: shipping_currency).last
		 
		amount = user.accounts.where(currency: tncurrency.id)
		.where("balance >= ?", tn_amount).last
		
		shipp = user.accounts.where(currency: shippingcurrency.id)
		.where("balance >= ?", shipping_amount).last
		 return true if amount && shipp
		 return false
	end

	

	def approve_by_buyer user
		if has_tn_amount? user

			lock_funds(user)
			 
			if tn_type == "seller" || tn_type == "buyer"
			  msg = "##{id}: Money escrow successfully accepted by buyer"
			  if buyer
			  	SrNotofication.create(
		          member_id: buyer.id,
		          link_page: "escrow",
		          msg: msg,
		          status: false)
				end
			else
			  tmp_role = user_role(user.email)

			  	msg = "##{id}: Money escrow successfully accepted by #{tmp_role}"
			  	if buyer
				  	SrNotofication.create(
			          member_id: buyer.id,
			          link_page: "escrow",
			          msg: msg,
			          status: false)
				end  

				if seller
				  	SrNotofication.create(
			          member_id: seller.id,
			          link_page: "escrow",
			          msg: msg,
			          status: false)
				end 
					
			  SrNotofication.create(
		          member_id: member.id,
		          link_page: "escrow",
		          msg: msg,
		          status: false)
			end

			return true

			
		end
	end

	def decline_by_buyer user
		if tn_type == "seller" || tn_type == "buyer"
			msg = "##{id}: Money escrow declined by buyer"
			if buyer
			  	SrNotofication.create(
		          member_id: buyer.id,
		          link_page: "escrow",
		          msg: msg,
		          status: false)
			end
		else
			msg = "##{id}: Money escrow declined by recepient"
			  	if buyer
				  	SrNotofication.create(
			          member_id: buyer.id,
			          link_page: "escrow",
			          msg: msg,
			          status: false)
				end  	

			  SrNotofication.create(
		          member_id: member.id,
		          link_page: "escrow",
		          msg: msg,
		          status: false)
		end
	end


	

	def unlock_and_sub_funds account, sum, fee, reason
    	account.unlock_and_sub_funds sum, locked: sum, fee: fee, reason: reason, ref: self
	end

	def sub_funds(account, amount, fee, reason, ref)
	    account.sub_funds(amount, fee, reason, ref)
  	end

  	def lock_funds user
  		tncurrency = Currency.where(code: tn_currency).last
		shippingcurrency = Currency.where(code: shipping_currency).last

		tn_account = user.accounts.where(currency: tncurrency.id).last
		sh_account = user.accounts.where(currency: shippingcurrency.id).last


    	tn_account.lock_funds(tn_amount, reason: Escrow::MONEYDB, ref: self)
    	sh_account.lock_funds(shipping_amount, reason: Escrow::MONEYSHDB, ref: self)

  	end

	def is_seller?
		return self.tn_role == "seller"
	end

	def is_buyer?
		return self.tn_role == "buyer"
	end

	def is_broker?
		return self.tn_role == "broker"
	end

	private

	def notify_users
		begin
			msg = nil
			if seller.nil? && status == "1"
				UserMailer.signup_request_escrow(self, seller_email).deliver
			end
			if buyer.nil? && status == "1"
				UserMailer.signup_request_escrow(self, buyer_email).deliver
			end

			if status == 4 #approved by admin
				msg = "##{id}: Escrow approved by admin!"
			end
			 
			if status == 5 #declined by admin
				msg = "##{id}: Escrow declined by admin!"
			end

			if msg && (status == 4 || status == 5)
				SrNotofication.create(
		          member_id: seller.id,
		          link_page: "escrow",
		          msg: msg,
		          status: false) if seller
				SrNotofication.create(
		          member_id: buyer.id,
		          link_page: "escrow",
		          msg: msg,
		          status: false) if buyer
			end


		rescue
			puts "email errors"
		end	
	end

 

end
