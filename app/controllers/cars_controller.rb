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
        params[:car][:user_ids].each do |user_id| 
            UserCar.create(user_id: user_id, car: @car)
        end
        # byebug
        redirect_to car_path(@car)
    end
    
    def edit
        # byebug
        @car = Car.find(params[:id])
    end

    def update
        # @garage = Garage.find(car_params[:garage_id])
        if @car = Car.update( make: car_params[:make], model: car_params[:model], license_plate: car_params[:license_plate], garage: @garage)
            puts "Updated"
        else
            puts "did not update"
            render :edit
        end
        byebug
        params[:car][:user_ids].each do |user_id| 
            puts "Hi 45"
            UserCar.find_or_create_by(user_id: user_id, car: @car)
        end
    
        redirect_to car_path(@car)
    end

    private

    def car_params
        params.require(:car).permit(:make, :model, :license_plate, :garage_id, :id)
    end

    # def user_params
    #     params.permit(user_id)
    # end
end
