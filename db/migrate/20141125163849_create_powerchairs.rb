class CreatePowerchairs < ActiveRecord::Migration
  def change
    create_table :powerchairs do |t|
      t.string :manufacturer
      t.string :model_type
      t.string :drive
      t.string :color
      t.string :inventory_tag
      t.string :serial_number

      t.timestamps
    end
  end
end
