class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :total_likes
      t.integer :project_id

      t.timestamps
    end
  end
end
