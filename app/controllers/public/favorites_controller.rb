class Public::FavoritesController < ApplicationController

  before_action :get_favorites, only: [:index]

  def index; end

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save

    get_favorites if request.referer.match(/\/users\/[0-9]{1,}\/favorites$/)

    # redirect_back fallback_location: posts_path
    render "favorite"
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy

    get_favorites if request.referer.match(/\/users\/[0-9]{1,}\/favorites$/)

    # redirect_back fallback_location: posts_path
    render "favorite"
  end

  private

  def get_favorites
    post_ids = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @posts = Post.where(id: post_ids).page(params[:page]).per(10)
  end

end
