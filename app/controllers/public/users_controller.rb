class Public::UsersController < ApplicationController

  def mypage
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
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
    @user = User.find_by_id(params[:id])
    #@user = User.find_by(id: params[:id])
    @user.destroy if @user
    flash[:notice] = "削除しました。"
    redurect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

end
