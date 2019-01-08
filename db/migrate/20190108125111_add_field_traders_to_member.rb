class AddFieldTradersToMember < ActiveRecord::Migration
  def change
    add_column :members, :trader, :boolean
  end
end
