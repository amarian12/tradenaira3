class AddStatusToEscrow < ActiveRecord::Migration
  def change
    add_column :escrows, :status, :string
  end
end
