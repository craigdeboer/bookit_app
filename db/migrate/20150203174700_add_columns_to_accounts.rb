class AddColumnsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :location, :boolean
    add_column :accounts, :inventory_tag, :boolean
    add_column :accounts, :wc_stf, :boolean
    add_column :accounts, :pc_features, :boolean
    add_column :accounts, :pc_tilt, :boolean
  end
end
