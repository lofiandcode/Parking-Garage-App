class FamiliesController < ApplicationController
    def edit
        @family = Family.find(family_params[:id])
    end

    def update
        @family = Family.find(family_params[:id])
        @updated_list_of_family_members = family_params[:user_ids]
        remove_and_reassign_to_new_family()
        @new_list_of_drivers = new_user_ids
        @new_list_of_drivers.each do |user_id|
            updated_user_car = UserCar.new(user_id: user_id, car: car)
            updated_user_car.save
        end
    end

    private

    def family_params
        params.require(family).permit(:user_ids, :id)
    end

    def remove_and_reassign_to_new_family(user)
        old_family = Family.find(user.family_id)
        user.family_id = Family.create.id

        #delete or family if no users are assigned to it.
        users_in_old_family = User.all.where(family_id: old_family.id)
        if users_in_old_family.length == 0
            old_family.destroy
        end
    end
end
