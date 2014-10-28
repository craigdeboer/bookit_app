class CreateWheelchairs < ActiveRecord::Migration
  def change
    create_table :wheelchairs do |t|
      t.string :manufacturer
      t.string :model
      t.integer :width
      t.integer :depth
      t.string :color
      t.string :inventory_number
      t.string :serial_number

      t.timestamps
    end
  end
end
