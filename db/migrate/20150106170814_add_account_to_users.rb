class AddAccountToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :account_id, :integer, index: true
  end
end
