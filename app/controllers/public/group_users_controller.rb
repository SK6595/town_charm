class Public::GroupUsersController < ApplicationController

  def create
    #post = Post.find(params[:post_id])
    #favorite = current_user.favorites.new(post_id: post.id)
    #favorite.save
    #redirect_back fallback_location: posts_path
    
    
    group = Group.find(params[:group_id])
    current_user.join_group(group)
    redirect_back fallback_location: groups_path
  end

  def destroy
    #post= Post.find(params[:post_id])
    #favorite = current_user.favorites.find_by(post_id: post.id)
    #favorite.destroy
    #redirect_back fallback_location: posts_path
    
    group = Group.find(params[:group_id])
    current_user.leave_group(group)
    redirect_back fallback_location: groups_path
  end
  
  def update
    @group_user = GroupUser.find(params[:id])
    
    if @group_user.update(group_user_params)
      flash[:notice] = "success"
    else
      flash[:alert] = "failed"
    end
    redirect_back(fallback_location: root_url)
  end

  private
  
  def group_user_params
    params.require(:group_user).permit(:status)
  end
end
