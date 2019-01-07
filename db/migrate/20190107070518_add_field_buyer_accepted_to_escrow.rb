class AddFieldBuyerAcceptedToEscrow < ActiveRecord::Migration
  def change
    add_column :escrows, :buyer_accepted, :boolean
    add_column :escrows, :seller_accepted, :boolean
  end
end
