class CreateMetaContents < ActiveRecord::Migration
  def change
    create_table :meta_contents do |t|
      t.string :title
      t.integer :meta_category_id
      t.text :description

      t.timestamps
    end
  end
end
