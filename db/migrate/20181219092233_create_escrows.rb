class CreateEscrows < ActiveRecord::Migration
  def change
    create_table :escrows do |t|
      t.string :email
      t.string :tn_type
      t.string :tn_role
      t.string :phone
      t.string :tn_currency
      t.decimal :tn_amount
      t.string :item_name
      t.string :shipping_currency
      t.decimal :shipping_amount
      t.string :fee_payer
      t.string :inspection_length
      t.text :descriptions
      t.integer :member_id
      t.integer :recepient_id

      t.timestamps
    end
  end
end
