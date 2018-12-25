class Escrow < ActiveRecord::Base
	belongs_to :member

	validates :tn_type, :tn_role, 
	:tn_currency, :tn_amount, :item_name, :shipping_currency, :shipping_amount,
	:fee_payer, :inspection_length, :descriptions, :member_id, :status, presence: true

	validates :seller_email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :is_buyer?
	validates :buyer_email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :is_seller? 
	validates :buyer_email, :seller_email, format: { with: URI::MailTo::EMAIL_REGEXP }, 
	if: :is_broker? 


	validates :tn_amount, numericality: { only_integer: true, greater_than_or_equal_to: 200 }

	after_save :notify_users

	def seller
		Member.find_by_email(seller_email)
	end

	def buyer
		Member.find_by_email(buyer_email)
	end


	private

	def is_seller?
		return self.tn_role == "seller"
	end

	def is_buyer?
		return self.tn_role == "buyer"
	end

	def is_broker?
		return self.tn_role == "broker"
	end

	def notify_users
		if seller.nil? && status == 1
			UserMailer.signup_request_escrow(self, seller_email).deliver
		end
		if buyer.nil? && status == 1
			UserMailer.signup_request_escrow(self, buyer_email).deliver
		end
	end

 

end
