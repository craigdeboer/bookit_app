class AddSeatToFloorToWheelchairs < ActiveRecord::Migration
  def change
    add_column :wheelchairs, :seat_to_floor, :string
  end
end
