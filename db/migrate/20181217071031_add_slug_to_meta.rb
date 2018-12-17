class AddSlugToMeta < ActiveRecord::Migration
  def change
    add_column :meta_contents, 		:slug, :string
    add_column :meta_categories, 	:slug, :string
  end
end
