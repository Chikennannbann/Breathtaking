class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post.tags
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    # byebug
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tags(tag_list)
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
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
      flash[:notice] = "編集が完了しました"
    else
      render 'edit'
    end

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:notice] = "投稿を削除しました"
  end


  private
    def post_params
      params.require(:post).permit(:end_user_id, :view_image, :title, :body, :nation, :prefecture, :place)
    end
end
