class CreateUserCars < ActiveRecord::Migration[6.0]
  def change
    create_table :user_cars do |t|
      t.integer :user_id
      t.integer :car_id

      t.timestamps
    end
  end
end
