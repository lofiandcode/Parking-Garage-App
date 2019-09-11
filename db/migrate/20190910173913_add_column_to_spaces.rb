class AddColumnToSpaces < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :garage_id, :integer
  end
end
