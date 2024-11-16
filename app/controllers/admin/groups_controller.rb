class Admin::GroupsController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!

  def index
    @groups = Group.all
  end

  def destroy
    @group = Group.find(params[:id])
    #@user = User.find_by(id: params[:id])
    @group.destroy
    flash[:notice] = "削除しました。"
    redirect_to admin_groups_path
  end

end
