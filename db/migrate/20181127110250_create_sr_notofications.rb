class CreateSrNotofications < ActiveRecord::Migration
  def change
    create_table :sr_notofications do |t|
      t.integer :member_id
      t.text :msg
      t.boolean :status

      t.timestamps
    end
  end
end
