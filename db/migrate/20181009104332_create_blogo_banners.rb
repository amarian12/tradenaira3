class CreateBlogoBanners < ActiveRecord::Migration
  def change
    create_table :blogo_banners do |t|
      t.string :title
      t.string :image
      t.integer :category

      t.timestamps
    end
  end
end
