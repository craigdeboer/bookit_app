class AddAccountIdToOthers < ActiveRecord::Migration
  def change
  	add_column :others, :account_id, :integer, index: true
  end
end
