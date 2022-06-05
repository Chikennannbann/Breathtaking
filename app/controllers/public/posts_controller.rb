class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to posts_path
      flash[:notice] = "投稿が完了しました"
    else
     render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
  end

  def destroy
  end


  private
    def post_params
      params.require(:post).permit(:view_image, :title, :body, :nation, :prefecture, :place)
    end
end
