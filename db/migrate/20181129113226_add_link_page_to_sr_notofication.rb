class AddLinkPageToSrNotofication < ActiveRecord::Migration
  def change
    add_column :sr_notofications, :link_page, :string
  end
end
