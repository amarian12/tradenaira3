class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.string :usdtxt
      t.string :poundtxt
      t.string :eurotxt

      t.timestamps
    end
  end
end
