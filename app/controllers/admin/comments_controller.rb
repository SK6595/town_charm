class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @comments = Comment.all
  end

  def destroy
    comment = Comment.find(params[:id]).destroy
    redirect_to admin_post_path(comment.post)
  end
end
