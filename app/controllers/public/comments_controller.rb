class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      @comments_count = Comment.where(post_id: @post.id).count
      flash[:notice] = "コメントが送信されました"
      #redirect_to post_path(@post)
    else
      flash.now[:alert] = "コメントが送信できませんでした"
      render "public/posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
    @comments_count = Comment.where(post_id: @post.id).count
    #redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
