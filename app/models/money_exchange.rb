class MoneyExchange < ActiveRecord::Base

 
	belongs_to :account
	attr_accessor :currency, :trans_errors, :update_success
	include Currencible
	STATUS_CODES = {
		pending: 0,
		active: 1,
		approved: 2,
		declined: 3,
		accepted_by_receipent: 4,
		declined_by_receipent: 5
	}

	REQTYPES = {
		send_money: 0,
		request_meney: 1
	}

	enumerize :status, in: STATUS_CODES, scope: true

	enumerize :request_type, in: REQTYPES, scope: true

	 


	def humunize_request_type
		case self.request_type
		when "send_money"
			"Send Money"
		when "request_meney"
			"Request Money"
		end
	end

	def accept_request
		self.status = 4
		if self.save
			#lock amount of seder
			self.lock_funds(self.receiver_account, self.amount, reason: nil, ref: nil)
			#send approval request to admin
			UserMailer.admin_approval(self).deliver
			#send confirmation to receiver
			#UserMailer.receive_success(self,self.sender).deliver
			return true
		end
		return false
	end

	def decline_request
		self.status = 5
		if self.save
			UserMailer.request_declined(self).deliver
			return true
		end
	end

	def sender
		Member.find_by_id(self.sent_by_id)
	end

	def receiver
		Member.find_by_email(self.sent_on_email)
	end

	def receiver_account
		unless receiver.nil?
			currency = Currency.where(code: self.account.currency).last
			receiver.accounts.where("currency=(?)",currency[:id]).last
		end
	end

	def sender_account
		unless sender.nil?
			currency = Currency.where(code: self.account.currency).last
			sender.accounts.where("currency=(?)",currency[:id]).last
		end
	end

	def approve_transuction
		 
		if self.request_type == "send_money"
			s_account = sender_account
			r_account = receiver_account
			unless s_account.nil?
				if s_account.balance >= self.amount 
					#debit aacount of sender
					unlock_and_sub_funds(s_account, self.amount, 0.0, Account::MONEYSENT)
					if s_account.save
						#r_account.balance = r_account.balance + self.amount

						real_fee = (self.amount*0.5)/100
						real_add = self.amount - real_fee

						r_account.plus_funds \
					    real_add, fee: real_fee,
					    reason: Account::MONEYRECEIVED, ref: self	

						r_account.save	
						self.update_success = true
						#send success mail to receiver
						UserMailer.receive_success(self,receiver).deliver
						#send success mail to sender
						UserMailer.sent_success(self, sender).deliver
					else
						self.trans_errors = s_account.errors.full_messages
					end
				else
					self.trans_errors = "Sender's account doesn't have sufficient balance."	
				end
			end
		elsif self.request_type == "request_meney"
			s_account = receiver_account
			r_account = sender_account

			unless s_account.nil?
				if s_account.balance >= self.amount 
					#debit aacount of sender
					unlock_and_sub_funds(s_account, self.amount, 0.0, Account::MONEYSENT)
					if s_account.save
						#r_account.balance = r_account.balance + self.amount

						real_fee = (self.amount*0.5)/100
						real_add = self.amount - real_fee

						r_account.plus_funds \
					    real_add, fee: real_fee,
					    reason: Account::MONEYRECEIVED, ref: self	

						r_account.save	
						self.update_success = true
						#send success mail to receiver
						UserMailer.receive_success(self,receiver).deliver
						#send success mail to sender
						UserMailer.sent_success(self, sender).deliver
					else
						self.trans_errors = s_account.errors.full_messages
					end
				else
					self.trans_errors = "Sender's account doesn't have sufficient balance."	
				end
			end

		end
		
	end
	#by admin user only
	def decline_transuction

		if self.request_type == "send_money"
			s_account = sender_account
			r_account = receiver_account
			unless s_account.nil?
				unlock_funds s_account, self.amount
			end
		elsif self.request_type == "request_meney"
			s_account = receiver_account
			r_account = sender_account	
			unlock_funds s_account, self.amount
		end

		
	end


	def unlock_and_sub_funds account, sum, fee, reason
		#unlock_and_sub_funds(amount, locked: ZERO, fee: ZERO, reason: nil, ref: nil)
    	#account.lock!
    	account.unlock_and_sub_funds sum, locked: sum, fee: fee, reason: reason, ref: self
  	end

  	def unlock_funds account, sum
       account.lock!
       account.unlock_funds sum, reason: Account::MONEYSENTCANCEL, ref: self
    end


    def lock_funds(account, amount, reason: nil, ref: nil)
    	( amount > account.balance) and raise AccountError, "cannot lock funds (amount: #{amount})"
    	account.change_balance_and_locked -amount, amount
    end


   




end
