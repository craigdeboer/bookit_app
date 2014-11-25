class CreateMattresses < ActiveRecord::Migration
  def change
    create_table :mattresses do |t|
      t.string :manufacturer
      t.string :model_type
      t.string :size
      t.string :inventory_tag
      t.string :serial_number

      t.timestamps
    end
  end
end
