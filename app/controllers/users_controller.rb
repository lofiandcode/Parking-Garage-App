class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @group = Group.create(name: "Not in a Group")
        @user = User.create(user_params)
        UserGroup.create(user: @user, group: @group)
        redirect_to user_path(@user)
    end
    
    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(name: user_params[:name])
            # byebug
            # update_user_group(@user, user_params[:user][:user_ids])
            flash[:success] = 'User information updated successfully!'
        else
            flash[:errors] = 'User information update failed'
            render :edit
        end
        redirect_to user_path(@user)
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        UserCar.delete_by_user(@user)
        redirect_to users_path, notice: "Delete Successful"
    end

    private

    def user_params
        params.require(:user).permit(:name, :user_ids,)
    end

    # def update_user_group (user, new_user_ids)
    #     UserGroup.delete_by_car(user)
    #     @new_list_of_drivers = new_user_ids
    #     @new_list_of_drivers.each do |user_id|
    #         updated_user_car = UserCar.new(user_id: user_id, car: car)
    #         updated_user_car.save
    #     end
    # end
end
