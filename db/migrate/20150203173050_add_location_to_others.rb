class AddLocationToOthers < ActiveRecord::Migration
  def change
    add_column :others, :location, :string
  end
end
