class AddUsersToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :user_limit, :integer
  end
end
