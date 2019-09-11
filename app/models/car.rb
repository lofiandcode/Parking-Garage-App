class Car < ApplicationRecord
    belongs_to :garage
    has_many :user_cars
    has_many :users, through: :user_cars
end
