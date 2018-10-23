class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :blurb, null: false
      t.string :description, null: false
      t.string :end_date, null: false
      t.integer :funding_goal, null: false
      t.string :image_url
  

      t.timestamps
    end
  end
end
