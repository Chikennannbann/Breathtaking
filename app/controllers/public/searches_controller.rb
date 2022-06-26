class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @end_user = EndUser.where("is_deleted = false")
    @posts = Post.looks(params[:word]).page(params[:page]).per(15).where(end_user_id: @end_user).order(created_at: :desc)
  end
end
