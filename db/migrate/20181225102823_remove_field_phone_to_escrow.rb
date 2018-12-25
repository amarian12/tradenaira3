class RemoveFieldPhoneToEscrow < ActiveRecord::Migration
  def change
    remove_column :escrows, :phone, :string
    add_column :escrows, :buyer_phone, :string
    add_column :escrows, :seller_phone, :string
  end
end
