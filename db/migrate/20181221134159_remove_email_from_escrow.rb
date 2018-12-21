class RemoveEmailFromEscrow < ActiveRecord::Migration
  def change
  	remove_column :escrows, :email, :string
    add_column :escrows, :buyer_email, :string
    add_column :escrows, :seller_email, :string
  end
end
