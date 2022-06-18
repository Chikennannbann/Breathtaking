class Public::TagsController < ApplicationController

  def index
    @tags = Tag.page(params[:page]).per(30).order(created_at: :desc)
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.page(params[:page]).per(15).order(created_at: :desc)
  end

  def destroy
     @tag = Tag.find(params[:id])
     @tag.destroy
     redirect_to request.referer
     flash[:notice] = "タグを削除しました"
  end
end
