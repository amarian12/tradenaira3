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

	MONEYTNFEE = :tn_fee

	FEE = 2.0 #% amount

	def get_status
		st = [	
			"pending", #-----------------0
			"active",#-------------------1
			"approved_buyer",#-----------2
			"declined_buyer",#-----------3
			"approved_admin",#-----------4
			"declined_admin",#-----------5
			"closed",#-------------------6
			"waiting_2nd_approval",#-----7
			"declined_by_seller",#--------8
			"approved_by_seller"#----------9
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
		tag = "<input type='button' class='selfeditobject editfield'"
		tag += "data-field='#{field}'"
		tag += "data-id='#{id}'"
		tag += "data-path='/admin/money/edit'"
		tag += "data-model='escrow'"
		tag += "value='#{send(field.to_sym)}'"
		tag += " />"
		 
		 
		tag

	end

	def user_role email
		return "seller" if (self.seller_email == email)
		return "buyer"  if (self.buyer_email == email)
		return "broker" if (self.tn_role == "broker" &&  self.member.email == email)
	end

	def is_user_amount_payer? user
		# if tn_role == "seller" || tn_role == "buyer"
		# 	return true if buyer_email == user.email
		# 	return true if fee_payer == user_role(user.email)
		# elsif tn_role == "broker"
		# 	return true if (amount_payer == user_role(user.email) && amount_payer != "")	
		# end
		# return false

		return true if user_role(user.email) == fee_payer
		return true if user_role(user.email) == amount_payer
		return false
	end

	def total_payable_amount member
		amount = ""
		user = member
		urole = user_role(user.email)

		# if amount payer and fee payer both users are same
		if fee_payer == amount_payer && fee_payer == urole
			# if shipping and transaction both currecies are same 
			if shipping_currency == tn_currency
				amount_1 = amount_with_fee(member) + shipping_amount
				amount = amount_1.to_s+tn_currency.upcase
			else
				amount_1 = amount_with_fee(member).to_s + tn_currency.upcase
				amount_2 = shipping_amount.to_s+shipping_currency.upcase
				amount = amount_1 + amount_2
			end
		# if amount payer and fee payer are diffrent person
		else
			# if only fee payer
			if urole == fee_payer
				amount += tn_fee.to_s+tn_currency.upcase
			end
			# if only amount payer
			if urole == amount_payer
				# if has set shipping 
				if shipping_amount > 0
					# if both currencies are same
			    	if shipping_currency == tn_currency
			    		amount = (tn_amount+shipping_amount).to_s+tn_currency.upcase
			    	else
			    		amount = tn_amount.to_s+tn_currency.upcase
			    		amount += " + "+shipping_amount.to_s+shipping_currency.upcase
			    	end
			    else
			    # if no shipping set	 
			      	amount = tn_amount.to_s+tn_currency.upcase
				end
			end
		end
		if amount == ""
			amount = 0.0
		end
		return amount
	end



	def is_user_fee_payer user
		return true if fee_payer == user_role(user.email)
		return false
	end

	def is_paid? member

		urole = user_role(member.email) 

		if urole == "seller"
			return true if seller_accepted
		end

		if urole == "buyer"
			return true if buyer_accepted
		end
		 
		return false 
	end

	def payment_status

		if ['3','4','5','6','8'].include?(status) 
			return get_status
		end
		
		if tn_role == "seller" || tn_role == "buyer" 
			if fee_payer == amount_payer
				if fee_payer == "buyer"
					return "buyer_paid" if buyer_accepted
					return "buyer_not_paid" unless buyer_accepted
				elsif fee_payer == "seller"
					return "seller_paid" if seller_accepted
					return "seller_not_paid" unless seller_accepted	
				end
			else
				return "buyer_seller_paid" if seller_accepted && buyer_accepted
				return "seller_paid_buyer_not_paid" if seller_accepted 
				return "buyer_paid_seller_not_paid" if buyer_accepted 
			end
		elsif tn_role == "broker"
			if fee_payer == amount_payer
				if  fee_payer == "buyer"
					if buyer_accepted
						return "buyer_paid"
					else
						return "buyer_not_paid"	
					end
				elsif fee_payer == "seller"
					if seller_accepted
						return "seller_paid"
					else
						return "seller_not_paid"	
					end		
				end
			else
				if seller_accepted && buyer_accepted
					return "buyer_seller_paid"
				elsif seller_accepted && !buyer_accepted
					return "seller_paid_buyer_not_paid"
				elsif (!seller_accepted && buyer_accepted)
					return "buyer_paid_seller_not_paid"	
				end
			end
		end	

		return "unknown"
	end

	def is_all_paid?
		if fee_payer == amount_payer
			if fee_payer == "buyer"
				return true if buyer_accepted
			elsif fee_payer == "seller"
				return true if seller_accepted	
			end
		else
			return true if seller_accepted && buyer_accepted
		end
	end

	def has_tn_amount? user
		tncurrency = Currency.where(code: tn_currency).last
		shippingcurrency = Currency.where(code: shipping_currency).last

		balance = tn_amount
		if fee_payer == user_role(user.email)
			balance += tn_fee
		end
		 
		amount = user.accounts.where(currency: tncurrency.id)
		.where("balance >= ?", balance).last

		
		
		shipp = user.accounts.where(currency: shippingcurrency.id)
		.where("balance >= ?", shipping_amount).last
		 return true if amount && shipp
		 return false
	end

	def amount_with_fee user
		if fee_payer == user_role(user.email)
			tn_amount+tn_fee
		else
			tn_amount
		end
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

	def unlock_fund account, amount, reason
		account.unlock_funds(amount, reason, self)
	end

	def sub_funds(account, amount, fee, reason, ref)
	    account.sub_funds(amount, fee, reason, ref)
  	end

  	def lock_funds user
  		tncurrency = Currency.where(code: tn_currency).last
		tn_account = user.accounts.where(currency: tncurrency.id).last
    	tn_account.lock_funds(tn_amount, reason: Escrow::MONEYDB.to_s+":#{id}", ref: self)
    	if shipping_currency
    		shippingcurrency = Currency.where(code: shipping_currency).last
    		sh_account = user.accounts.where(currency: shippingcurrency.id).last
    		if sh_account
    			sh_account.lock_funds(shipping_amount, reason: Escrow::MONEYSHDB.to_s+":#{id}", ref: self)
    		end
    	end
    	#fee amount
    	lock_fee_amount(user.email)
  	end

  	def lock_fee_amount email
  		if fee_payer == user_role(email)
  			fee = tn_fee
  			tncurrency = Currency.where(code: tn_currency).last
  			member = Member.find_by_email(email)
  			if member
  			  tn_account = member.accounts.where(currency: tncurrency.id).last
  			  tn_account.lock_funds(tn_fee, reason: Escrow::MONEYTNFEE.to_s+":#{id}", ref: self)
  			end
  		end
  	end

  	def tn_fee
  		(tn_amount*Escrow::FEE)/100
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

			if status == 4 || status == 5
				tncurrency = Currency.where(code: tn_currency).last
				shippingcurrency = Currency.where(code: shipping_currency).last
			end

			if status == 4 #approved by admin
				msg = "##{id}: Escrow approved by admin!"
				if tn_role == "seller" || tn_role == "buyer" 
					if buyer
					  	tn_account = buyer.accounts.where(currency: tncurrency.id).last
					  	unlock_and_sub_funds tn_account, tn_amount, 0.0, Escrow::MONEYDB.to_s+":#{id}"
					  
						  if shippingcurrency
						  	sh_account = buyer.accounts.where(currency: shippingcurrency.id).last
						  	if sh_account
						  		unlock_and_sub_funds sh_account, shipping_amount, 0.0, 
						  		Escrow::MONEYDB.to_s+":#{id}"
						  	end
						  end  
					end
				elsif tn_role == "broker"
					if amount_payer == "seller" && seller 
						tn_account = seller.accounts.where(currency: tncurrency.id).last
					  	unlock_and_sub_funds tn_account, tn_amount, 0.0, 
					  	Escrow::MONEYDB.to_s+":#{id}"
					  	if shippingcurrency
						  	sh_account = seller.accounts.where(currency: shippingcurrency.id).last
						  	if sh_account
						  		unlock_and_sub_funds sh_account, shipping_amount, 0.0, 
						  		Escrow::MONEYDB.to_s+":#{id}"
						  	end
						end
					elsif amount_payer == "buyer" && buyer 
						tn_account = buyer.accounts.where(currency: tncurrency.id).last
					  	unlock_and_sub_funds tn_account, tn_amount, 0.0, 
					  	Escrow::MONEYDB.to_s+":#{id}"
					  	if shippingcurrency
						  	sh_account = buyer.accounts.where(currency: shippingcurrency.id).last
						  	if sh_account
						  		unlock_and_sub_funds sh_account, shipping_amount, 0.0, 
						  		Escrow::MONEYDB.to_s+":#{id}"
						  	end
						end 		 
					end		
				end
			end
			 
			if status == 5 #declined by admin
				msg = "##{id}: Escrow declined by admin!"
				
				if tn_role == "seller" || tn_role == "buyer"
					if buyer
						tn_account = buyer.accounts.where(currency: tncurrency.id).last
						unlock_fund(tn_account, tn_amount, 
							Escrow::MONEYRB.to_s+":#{id}")
						if shippingcurrency
						  	sh_account = buyer.accounts.where(currency: shippingcurrency.id).last
						  	if sh_account
						  		unlock_fund(sh_account, shipping_amount, 
						  			Escrow::MONEYSHRB.to_s+":#{id}")
						  	end
						end 	
					end
				elsif tn_role == "broker"
					if amount_payer == "seller" && seller 
						tn_account = seller.accounts.where(currency: tncurrency.id).last
					  	unlock_fund(tn_account, tn_amount, Escrow::MONEYRB.to_s+":#{id}")
					  	if shippingcurrency
						  	sh_account = seller.accounts.where(currency: shippingcurrency.id).last
						  	if sh_account
						  		unlock_fund(sh_account, shipping_amount, Escrow::MONEYSHRB.to_s+":#{id}")
						  	end
						end
					elsif amount_payer == "buyer" && buyer 
						tn_account = buyer.accounts.where(currency: tncurrency.id).last
						unlock_fund(tn_account, tn_amount, Escrow::MONEYRB.to_s+":#{id}")
						if shippingcurrency
						  	sh_account = buyer.accounts.where(currency: shippingcurrency.id).last
						  	if sh_account
						  		unlock_fund(sh_account, shipping_amount, Escrow::MONEYSHRB.to_s+":#{id}")
						  	end
						end 			 
					end			
				end
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
