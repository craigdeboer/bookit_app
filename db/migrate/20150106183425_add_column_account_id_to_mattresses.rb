class AddColumnAccountIdToMattresses < ActiveRecord::Migration
  def change
  	add_column :mattresses, :account_id, :integer, index: true
  end
end
