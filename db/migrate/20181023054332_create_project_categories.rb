class CreateProjectCategories < ActiveRecord::Migration
  def change
    create_table :project_categories do |t|
      t.integer :category_id
      t.integer :project_id

      t.timestamps
    end
  end
end
