class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.string :number

      t.timestamps
    end
  end
end
