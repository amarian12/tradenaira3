class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :title
      t.integer :project_id
      t.integer :amount_met

      t.timestamps
    end
  end
end
