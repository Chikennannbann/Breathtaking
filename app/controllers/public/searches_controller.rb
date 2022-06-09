class Public::SearchesController < ApplicationController

  def search
    @word = params[:word]
    @posts = Post.looks(params[:word])
  end
end
