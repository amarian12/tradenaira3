class MoneyExchange < ActiveRecord::Base
	belongs_to :account
	attr_accessor :currency
	include Currencible
	STATUS_CODES = {
		pending: 0,
		active: 1,
		approved: 2,
		declined: 3
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




end
