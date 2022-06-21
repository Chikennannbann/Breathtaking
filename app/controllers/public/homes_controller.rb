class Public::HomesController < ApplicationController

  def top
    @end_user = EndUser.where("is_deleted = false")
    @posts = Post.all.where(end_user_id: @end_user).order(created_at: :desc).first(9)
  end

  def about
  end
end
