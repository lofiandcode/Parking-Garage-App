class AddColumnToCars < ActiveRecord::Migration[6.0]
  def change
    add_column :cars, :family_id, :integer
    add_column :cars, :space_id, :integer
  end
end
