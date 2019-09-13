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
        # byebug
        @group = Group.create(name: "Not in a Group")
        # byebug
        @user = User.create(user_params)
        # byebug
        UserGroup.create(user: @user, group: @group)
        # byebug
        redirect_to user_path(@user)
    end
    
    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
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
end
