class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.end_user_id = current_end_user.id
    comment.post_id = @post.id
    comment.save
    redirect_to post_path(@post)
    flash[:notice] = "投稿にコメントしました"
  end

  def destroy
    PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    redirect_to post_path(@post)
    flash[:notice] = "コメントを削除しました"
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

end
