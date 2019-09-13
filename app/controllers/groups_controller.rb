class GroupsController < ApplicationController

    def show
        @group = Group.find(params[:id])
    end


    def edit
        @group = Group.find(params[:id])
    end

    def update
        @group = Group.find(params[:id])
        
        if @group.update(group_params)
            update_user_group(@group, group_params)
            flash[:success] = 'group information updated successfully!'
        else
            flash[:errors] = 'group information update failed'
            render :edit
        end
        redirect_to group_path(@group)
    end

    private

    def group_params
        params.require(:group).permit(:user_ids)
    end

    #Look up info on additional renders in private helper methods
    def update_user_group (group, new_user_ids)
        UserGroup.delete_by_group(group)
        @new_list_of_users = new_user_ids
        @new_list_of_users.each do |user_id|
            updated_user_group = UserGroup.new(user_id: user_id, group: group)
            updated_user_group.save
        end
    end

end
