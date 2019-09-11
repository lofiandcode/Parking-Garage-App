class Space < ApplicationRecord
    has_one :car
    belongs_to :garage
end
