class RemoveTraderFromMember < ActiveRecord::Migration
  def change
    remove_column :members, :trader, :boolean
    add_column :members, :trader, :integer
  end
end
