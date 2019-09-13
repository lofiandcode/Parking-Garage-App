class UserGroup < ApplicationRecord
    belongs_to :group
    belongs_to :user

    def self.delete_by_group(group)
        # byebug
        joins = UserGroup.where(group_id: group.id)
        joins.each {|join| join.destroy}
    end

    def self.delete_by_user(user)
        joins = UserGroup.where(user_id: user.id)
        joins.each {|join| join.destroy}
    end
end
