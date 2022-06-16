class Public::TagsController < ApplicationController

  def index
    @tags = Tag.all.order(created_at: :desc)
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.page(params[:page]).per(15).order(created_at: :desc)
  end
end
