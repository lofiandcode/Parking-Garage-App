class RenameColumnOnCars < ActiveRecord::Migration[6.0]
  def change
    rename_column :cars, :space_id, :garage_id
  end
end
