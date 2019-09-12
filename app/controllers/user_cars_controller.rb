class UserCarsController < ApplicationController

    def edit
    
        @car = Car.find(params[:id])
        # render new.html.erb
    end

    def update
        byebug
        @car = Car.find(params[:id])
        byebug
        # if @car.update(car_params)
        #     # puts "Updated"
        # else
        #     # puts "did not update"
        #     render :edit
        # end
    
        params[:car][:user_ids].each do |user_id| 
            UserCar.find_or_create_by(user_id: user_id, car: @car)
        end
        byebug
        # UserCar.create(user_id: user_id, car: @car)
        redirect_to car_path(@car)
    end

    # private

    def user_car_params
        params.require(:user_car).permit(:user_id, :car_id)
    end
end
