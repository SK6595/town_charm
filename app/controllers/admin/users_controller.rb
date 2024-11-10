class Admin::UsersController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    #@user = User.find_by(id: params[:id])
    @user.update(is_active: false)
    flash[:notice] = "削除しました。"
    redirect_to admin_user_path(@user)
  end
end


