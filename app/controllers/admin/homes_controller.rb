class Admin::HomesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def top
    @active_users = User.active_users
    @deleted_users = User.deleted_users
  end
end
