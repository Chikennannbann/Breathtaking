class Public::PostCommentsController < ApplicationController
  before_action :ensure_guest_end_user

  def create
    post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.end_user_id = current_end_user.id
    @comment.post_id = post.id
    @comment.save
  end

  def destroy
    @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

  def ensure_guest_end_user
    if current_end_user.name == "ゲストユーザー"
      redirect_to request.referer, notice: 'ゲストユーザーではご利用いただけません'
    end
  end
end
