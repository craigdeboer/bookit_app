class AddLocationToMattresses < ActiveRecord::Migration
  def change
    add_column :mattresses, :location, :string
  end
end
