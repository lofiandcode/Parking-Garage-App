class Family < ApplicationRecord
    has_many :user_families
    has_many :users, through: :user_families
end
