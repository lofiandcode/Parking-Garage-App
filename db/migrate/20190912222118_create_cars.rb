class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.string :license_plate
      t.integer :garage_id

      t.timestamps
    end
  end
end
