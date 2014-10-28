class ChangeColumnNameToWheelchairs < ActiveRecord::Migration
  def change
  	rename_column :wheelchairs, :inventory_number, :inventory_tag
  end
end
