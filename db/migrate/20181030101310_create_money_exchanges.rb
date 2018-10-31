class CreateMoneyExchanges < ActiveRecord::Migration
  def change
    create_table :money_exchanges do |t|
      t.integer :sent_by_id
      t.integer :sent_to_id
      t.string :sent_on_email
      t.integer :status
      t.text :note
      t.text :declined_note
      t.decimal :amount
      t.datetime :approved_at

      t.timestamps
    end
  end
end
