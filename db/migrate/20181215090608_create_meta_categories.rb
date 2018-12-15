class CreateMetaCategories < ActiveRecord::Migration
  def change
    create_table :meta_categories do |t|
      t.string :title
      t.integer :parent_id

      t.timestamps
    end
  end
end
