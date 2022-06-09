class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "国名"
      @posts = Post.where(['nation LIKE?', "%#{@word}%"])
    elsif @range == "県・州名"
      @posts = Post.where(['prefecture LIKE?', "%#{@word}%"])
    elsif @range == "スポット名"
      @posts = Post.where(['place LIKE?', "%#{@word}%"])
    else
      @posts = Post.all
    end
  end
end
