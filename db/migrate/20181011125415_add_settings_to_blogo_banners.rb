class AddSettingsToBlogoBanners < ActiveRecord::Migration
  def change
    add_column :blogo_banners, :settings, :string
  end
end
