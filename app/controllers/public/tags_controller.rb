class Public::TagsController < ApplicationController
  def index
    @end_user = EndUser.where("is_deleted = false")
    @posts = Post.where(end_user: @end_user)
    @tags = Tag.page(params[:page]).per(30).order(created_at: :desc)
  end

  def show
    @tag = Tag.find(params[:id])
    @end_user = EndUser.where("is_deleted = false")
    @posts = @tag.posts.page(params[:page]).per(15).where(end_user_id: @end_user).order(created_at: :desc)
  end
end
