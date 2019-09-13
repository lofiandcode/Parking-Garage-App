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
        
        UserGroup.delete_by_group(group)
        new_user_ids.shift
        
        new_user_ids.each do |user_id|
            updated_user_group = UserGroup.new(user_id: user_id, group: group)
            updated_user_group.save
            
            puts ''
            user = User.find(user_id)
            
            delete_empty_groups(user.groups)
        end
    end

    def create_new_group_if_not_in_group(current_group, users_in_group)
        users_in_group.each do |user|
            group_joins = UserGroup.where(user: user)
            if !(group_joins.length > 1) && group_joins.length != 0
                new_group = Group.create(name: "Not in a Group")
                UserGroup.create(group: new_group, user: user)  
            end
        end
    end

    def delete_empty_groups(groups)
            empty_group = groups.select {|group| group.name == "Not in a Group"}

        if empty_group.length == 1 && empty_group.length != 0
            empty_group_join = UserGroup.find_by(group: empty_group)
            empty_group.first.destroy
            empty_group_join.destroy
        end
    end

end
