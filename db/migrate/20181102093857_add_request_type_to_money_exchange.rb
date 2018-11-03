class AddRequestTypeToMoneyExchange < ActiveRecord::Migration
  def change
    add_column :money_exchanges, :request_type, :integer
  end
end
