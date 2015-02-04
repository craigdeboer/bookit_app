class AddTiltToPowerchairs < ActiveRecord::Migration
  def change
    add_column :powerchairs, :tilt, :boolean
  end
end
