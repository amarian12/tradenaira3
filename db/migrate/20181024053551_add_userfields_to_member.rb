class AddUserfieldsToMember < ActiveRecord::Migration
  def change
    add_column :members, :username, :string
    add_column :members, :session_token, :string
    add_column :members, :password_digest, :string
  end
end
