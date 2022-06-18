class Public::HomesController < ApplicationController

  def top
    @posts = Post.all.order(created_at: :desc).first(9)
  end

  def about
  end
end
