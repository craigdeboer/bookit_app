class AddLocationToPowerchairs < ActiveRecord::Migration
  def change
    add_column :powerchairs, :location, :string
  end
end
