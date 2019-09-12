class FamiliesController < ApplicationController
    def edit
        @family = Family.find(family_params[:id])
    end

    def update
        
    end

    private

    def family_params
        params.require(family).permit(:user_ids, :id)
    end
end
