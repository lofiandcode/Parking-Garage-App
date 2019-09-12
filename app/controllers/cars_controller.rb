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
        @car = Car.find(params[:id])
    end

    def update
        @car = Car.find(params[:id])
        # byebug
        if @car.update(car_params)
            flash[:success] = 'Car information updated successfully!'
        else
            flash[:errors] = 'Car information update failed'
            render :edit
        end

        @current_driver_joins = UserCar.where(car: @car)
        @current_driver_joins.each {|user_car_join| user_car_join.destroy }
        @new_list_of_drivers = params[:car][:user_ids]

        @new_list_of_drivers.each do |user_id|
            updated_user_car = UserCar.new(user_id: user_id, car: @car)
            if updated_user_car.save
                flash[:success] = 'Driver updated successfully!'
            else
                flash[:errors] = 'Driver update failed'
                render :edit
            end
        end

        # byebug
        # params[:car][:user_ids].each do |user_id| 
        #     UserCar.find_or_create_by(user_id: user_id, car: @car)
        # end
    
        redirect_to car_path(@car)
    end

    private

    def car_params
        params.require(:car).permit(:make, :model, :license_plate, :garage_id)
    end
end
