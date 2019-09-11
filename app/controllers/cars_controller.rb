class CarsController < ApplicationController
    def index
        @cars = Car.all
    end

    def show
        @car = Car.find(params[:id])
    end

    def new
        @car = Car.new
    end

    def create
        
        @garage = Garage.find(car_params[:garage_id])
        @car = Car.create(
            make: car_params[:make], 
            model: car_params[:model],
            license_plate: car_params[:license_plate],
            garage: @garage
        )
        
        redirect_to new_user_car_path(@car)
    end
    
    def edit
        @car = Car.find(params[:id])
        @garage = Garage.find(car_params[:garage_id])
        @car = Car.update(
            make: car_params[:make], 
            model: car_params[:model],
            license_plate: car_params[:license_plate],
            garage: @garage
        )
        car_params[:user_id].each do |user_id| 
            UserCar.find_or_create_by(user_id: user_id, car: @car)
        end
    end

    def update
        @car = Car.find(params[:id])
        @car.update(car_params)
        redirect_to car_path(@car)
    end

    private

    def car_params
        params.require(:car).permit(:make, :model, :license_plate, :garage_id)
    end

    # def user_params
    #     params.permit(user_id)
    # end
end
