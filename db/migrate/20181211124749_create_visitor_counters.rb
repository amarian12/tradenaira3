class CreateVisitorCounters < ActiveRecord::Migration
  def change
    create_table :visitor_counters do |t|
      t.string :ip_address
      t.boolean :is_signedin
      t.integer :member_id

      t.timestamps
    end
  end
end
