class Escrow < ActiveRecord::Base
	belongs_to :member

	validates :tn_type, :tn_role, :phone, 
	:tn_currency, :tn_amount, :item_name, :shipping_currency, :shipping_amount,
	:fee_payer, :inspection_length, :descriptions, :member_id, :status, presence: true

	validates :seller_email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :is_buyer?
	validates :buyer_email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :is_seller? 


	validates :tn_amount, numericality: { only_integer: true, greater_than_or_equal_to: 200 }





	private

	def is_seller?
		return self.tn_type == "seller"
	end

	def is_buyer?
		return self.tn_type == "buyer"
	end

end
