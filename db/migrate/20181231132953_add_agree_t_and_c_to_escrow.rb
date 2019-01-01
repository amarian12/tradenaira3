class AddAgreeTAndCToEscrow < ActiveRecord::Migration
  def change
    add_column :escrows, :agree_tc, :boolean
  end
end
