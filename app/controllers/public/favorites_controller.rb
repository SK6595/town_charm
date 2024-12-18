class Public::FavoritesController < ApplicationController

  def index
    post_ids = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @posts = Post.where(id: post_ids).page(params[:page]).per(10)
  end

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    # redirect_back fallback_location: posts_path
    render "favorite"
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    # redirect_back fallback_location: posts_path
    render "favorite"
  end

end
