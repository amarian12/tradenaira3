class Escrow < ActiveRecord::Base
	belongs_to :member

	validates :email, :tn_type, :tn_role, :phone, 
	:tn_currency, :tn_amount, :item_name, :shipping_currency, :shipping_amount,
	:fee_payer, :inspection_length, :descriptions, :member_id, :status, presence: true

	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :tn_amount, numericality: { only_integer: true, greater_than_or_equal_to: 200 }

end
