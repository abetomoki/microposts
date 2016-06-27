class FavoriteRelationshipsController < ApplicationController
      before_action :logged_in_user

    def create
        @micropost = Micropost.find(params[:micropost_id])
        current_user.favo(@micropost)
        redirect_to :back
    end
    
    def destroy
        @micropost = current_user.favorite_relationships.find(params[:id]).micropost
        current_user.unfavo(@micropost)
        redirect_to :back
    end
end
