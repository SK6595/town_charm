class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :require_active_user, only: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def mypagegit
  end

  def index
    @users = User.where(is_active: true)
    @user = current_user
    @post = Post.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
    @notifications = @user.notifications
    @following_posts = Post.where(user_id: @user.followings.ids).order(created_at: :desc).take(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.is_guest
      flash[:notice] = "ゲストユーザーは退会できません"
      redirect_to user_path(@user.id)
    else
      #@user = User.find_by(id: params[:id])
      @user.update(is_active: false)
      sign_out(@user)
      flash[:notice] = "削除しました。"
      redirect_to new_user_registration_path
    end
  end

  def re_sign_in
  end

  def update_re_sign_in
    current_user.update(is_active: true)
    flash[:notice] = "復活しました"
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user)if current_user != @user
  end
end
