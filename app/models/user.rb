class User < ApplicationRecord
    has_many :user_cars
    has_many :cars, through: :user_cars
    has_many :user_groups
    has_many :groups, through: :user_groups
end
