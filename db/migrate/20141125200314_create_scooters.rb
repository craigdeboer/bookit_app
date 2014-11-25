class CreateScooters < ActiveRecord::Migration
  def change
    create_table :scooters do |t|
      t.string :manufacturer
      t.string :model_type
      t.string :wheels
      t.string :color
      t.string :inventory_tag
      t.string :serial_number

      t.timestamps
    end
  end
end
