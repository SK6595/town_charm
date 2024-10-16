class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])  
  end

  def create
    #データを受け取り新規登録するためのインスタンス作成
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @post.save
    # 4. 詳細画面へリダイレクト
    redirect_to post_path(@post.id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
  end

  def destroy
  end
end

private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end