class AddFeaturesToPowerchairs < ActiveRecord::Migration
  def change
    add_column :powerchairs, :features, :string
  end
end
