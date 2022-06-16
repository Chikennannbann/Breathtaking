class Public::SearchesController < ApplicationController

  def search
    @word = params[:word]
    @posts = Post.looks(params[:word]).page(params[:page]).per(15).order(created_at: :desc)
  end
end
