class AddAccountToWheelchairs < ActiveRecord::Migration
  def change
    add_column :wheelchairs, :account_id, :integer
    add_index :wheelchairs, :account_id
  end
end
