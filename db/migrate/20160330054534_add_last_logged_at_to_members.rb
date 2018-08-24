class AddLastLoggedAtToMembers < ActiveRecord::Migration
  def change
    add_column :members, :last_logged_at, :datetime
  end
end
