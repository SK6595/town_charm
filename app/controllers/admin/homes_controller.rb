class Admin::HomesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def top
    @active_users = User.active_users.page(params[:active_users_page]).per(5)
    @deleted_users = User.deleted_users.page(params[:deleted_users_page]).per(5)
  end
end
