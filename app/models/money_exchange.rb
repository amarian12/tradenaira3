class MoneyExchange < ActiveRecord::Base
	belongs_to :account
	attr_accessor :currency
	include Currencible
	STATUS_CODES = {
		pending: 0,
		approved: 1,
		declined: 2
	}

enumerize :status, in: STATUS_CODES, scope: true


end
