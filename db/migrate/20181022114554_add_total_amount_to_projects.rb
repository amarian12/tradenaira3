class AddTotalAmountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :total_amount, :integer
  end
end
