class AddFieldAmountPayerToEscrow < ActiveRecord::Migration
  def change
    add_column :escrows, :amount_payer, :string
  end
end
