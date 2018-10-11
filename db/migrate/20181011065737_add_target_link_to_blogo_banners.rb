class AddTargetLinkToBlogoBanners < ActiveRecord::Migration
  def change
    add_column :blogo_banners, :target_link, :string
  end
end
