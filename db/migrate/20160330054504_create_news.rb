class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :name
      t.string :summary
      t.string :image

      t.timestamps
    end
  end
end
