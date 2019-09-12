class User < ApplicationRecord
    has_many :user_cars
    has_many :cars, through: :user_cars
    has_many :user_families
    has_many :families, through: :user_families
end
