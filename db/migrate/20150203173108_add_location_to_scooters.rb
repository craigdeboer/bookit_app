class AddLocationToScooters < ActiveRecord::Migration
  def change
    add_column :scooters, :location, :string
  end
end
