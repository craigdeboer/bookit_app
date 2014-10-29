class ChangeModelColumnNameInWheelchairs < ActiveRecord::Migration
  def change
  	rename_column :wheelchairs, :model, :model_type
  end
end
