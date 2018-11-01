class AddAccountIdToMoneyExchange < ActiveRecord::Migration
  def change
    add_column :money_exchanges, :account_id, :integer
  end
end
