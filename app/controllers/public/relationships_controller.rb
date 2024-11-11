class Public::RelationshipsController < ApplicationController

  def create
    Relationship.create(follower_id: current_user.id, followed_id: params[:user_id])
    redirect_to request.referer
  end

  def destroy
    pp Relationship.find_by(follower_id: current_user.id, followed_id: params[:user_id]).destroy
    redirect_to request.referer
  end

end
