class AddAccountToScooters < ActiveRecord::Migration
  def change
    add_column :scooters, :account_id, :integer
    add_index :scooters, :account_id
  end
end
