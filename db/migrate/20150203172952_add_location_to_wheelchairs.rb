class AddLocationToWheelchairs < ActiveRecord::Migration
  def change
    add_column :wheelchairs, :location, :string
  end
end
