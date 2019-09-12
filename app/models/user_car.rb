class UserCar < ApplicationRecord
    belongs_to :user
    belongs_to :car

    def self.delete_by_car(car)
        joins = UserCar.where(car_id: car.id)
        joins.each {|join| join.destroy}
    end

    def self.delet_by_user(user)
        joins = UserCar.where(user_id: user.id)
        joins.each {|join| join.destroy}
    end

end
