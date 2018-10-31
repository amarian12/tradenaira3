class MoneyExchange < ActiveRecord::Base
	attr_accessor :currency
	include Currencible
	STATUS_CODES = {
		pending: 0,
		approved: 1,
		declined: 2
	}

enumerize :status, in: STATUS_CODES, scope: true


end
