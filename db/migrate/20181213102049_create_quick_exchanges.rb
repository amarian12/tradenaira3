class CreateQuickExchanges < ActiveRecord::Migration
  def change
    create_table :quick_exchanges do |t|
      t.string :base_currency
      t.string :target_currency
      t.integer :member_id
      t.decimal :amount
      t.integer :status
      t.text :note
      t.text :admin_not

      t.timestamps
    end
  end
end
