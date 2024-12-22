class Public::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @post = Post.new
    if params[:sort] == 'new'
      @posts = Post.active_user.page(params[:page]).per(10).order(created_at: :desc)
    elsif params[:sort] == 'old'
      @posts = Post.active_user.page(params[:page]).per(10).order(created_at: :asc)
    elsif params[:sort] == 'good'
      @posts = Post.active_user.joins(:favorites).group('favorites.post_id').order('count(favorites.post_id) desc').page(params[:page]).per(10)#.sort{|a,b| b.favorites.count <=> a.favorites.count}
    elsif params[:sort] == 'comment'
      @posts = Post.active_user.joins(:comments).group('comments.post_id').order('count(comments.post_id) desc').page(params[:page]).per(10)#.sort{|a,b| b.comments.count <=> a.comments.count}
    else
      @posts = Post.active_user.page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create

    #データを受け取り新規登録するためのインスタンス作成
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @post.save
    # 4. 詳細画面へリダイレクト
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿に失敗しました。" #キーをalertに変更
      @posts = Post.all
      @user = current_user
      @notifications = @user.notifications
      @following_posts = Post.where(user_id: @user.followings.ids).order(created_at: :desc).take(5)
      render 'public/users/show'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])  # データ（レコード）を1件取得
    post.destroy  # データ（レコード）を削除
    redirect_to user_path(post.user)  # 投稿一覧画面へリダイレクト
  end
end

private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :body, :image, :address)
  end

  def correct_user
    @post = Post.find(params[:id])
    redirect_to posts_path if current_user != @post.user
  end