class RemoveColumnOnCars < ActiveRecord::Migration[6.0]
  def change
    remove_column :cars, :family_id
  end
end
