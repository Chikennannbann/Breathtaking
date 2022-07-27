class Public::PostCommentsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:destroy]
  before_action :ensure_guest_end_user

  def create
    post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.end_user_id = current_end_user.id
    @comment.post_id = post.id
    render :validater unless @comment.save
    # 非同期でもエラー表示
  end

  def destroy
    @comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

  def ensure_correct_end_user
    @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    unless @comment.end_user == current_end_user
      redirect_to posts_path
    end
  end

  def ensure_guest_end_user
    if current_end_user.name == "ゲストユーザー"
      redirect_to request.referer, notice: t('notice.guest_alert')
    end
  end
end
