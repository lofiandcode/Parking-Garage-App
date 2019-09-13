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
            update_user_group(@group, params[:group][:user_ids])
            flash[:success] = 'group information updated successfully!'
        else
            flash[:errors] = 'group information update failed'
            render :edit
        end
        redirect_to group_path(@group)
    end

    def destroy
        @group = Group.find(params[:id])
        create_new_group_if_not_in_group(@group, @group.users)
        UserGroup.delete_by_group(@group)
        @group.destroy
        redirect_to users_path, notice: "Delete Successful"
    end

    private

    def group_params
        params.require(:group).permit(:name)
    end

    #Look up info on additional renders in private helper methods
    def update_user_group (group, new_user_ids)
        # byebug
        UserGroup.delete_by_group(group)
        @new_list_of_users = new_user_ids
        @new_list_of_users.each do |user_id|
            updated_user_group = UserGroup.new(user_id: user_id, group: group)
            updated_user_group.save
        end
    end

    def create_new_group_if_not_in_group(current_group, users_in_group)
        users_in_group.each do |user|
            groups = user.groups
            if !(groups.length > 1) && groups.length != 0
                new_group = Group.create(name: "Not in a Group")
                UserGroup.create(group: new_group, user: user)
            end
        end
    end

end
