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
        
        redirect_to car_path(@car)
    end
    
    def edit
        @car = Car.find(params[:id])
    end

    def update
        @car = Car.find(params[:id])
        
        if @car.update(car_params)
            update_user_car(@car, params[:car][:user_ids])
            flash[:success] = 'Car information updated successfully!'
        else
            flash[:errors] = 'Car information update failed'
            render :edit
        end

        redirect_to car_path(@car)
    end

    def destroy
        @car = Car.find(params[:id])
        UserCar.delete_by_car(@car)
        @car.destroy
        redirect_to cars_path, notice: "Delete Successful"
    end

    private

    def car_params
        params.require(:car).permit(:make, :model, :license_plate, :garage_id)
    end
    
    #Look up info on additional renders in private helper methods
    def update_user_car (car, new_user_ids)
        UserCar.delete_by_car(car)
        @new_list_of_drivers = new_user_ids
        @new_list_of_drivers.each do |user_id|
            updated_user_car = UserCar.new(user_id: user_id, car: car)
            updated_user_car.save
        end
    end
end
