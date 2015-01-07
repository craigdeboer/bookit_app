class AddAccountToPowerchairs < ActiveRecord::Migration
  def change
    add_column :powerchairs, :account_id, :integer, index: true
  end
end
