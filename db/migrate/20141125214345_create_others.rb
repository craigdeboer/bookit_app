class CreateOthers < ActiveRecord::Migration
  def change
    create_table :others do |t|
      t.string :manufacturer
      t.string :model_type
      t.string :inventory_tag
      t.string :description

      t.timestamps
    end
  end
end
