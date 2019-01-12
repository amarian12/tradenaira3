class RemoveTradeAndAddMemberToMember < ActiveRecord::Migration
  def change
    remove_column :members, :trader, :integer
    add_column :members, :membership, :integer
  end
end
