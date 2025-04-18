class Public::GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group =Group.new
  end

  def index
    @post = Post.new
    @groups = Group.all
  end

  def show
    @post = Post.new
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = '作成しました'
      redirect_to groups_path
    else
      flash.now[:alert] = '作成に失敗しました'
      render 'new'
    end

  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = '作成しました'
      redirect_to groups_path
    else
      flash.now[:alert] = '作成に失敗しました'
      render "edit"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
