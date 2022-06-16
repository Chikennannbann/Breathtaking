class Public::PostsController < ApplicationController
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_end_user, except: [:index, :show, :new]

  def index
    @posts = Post.page(params[:page]).per(15).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).per(5)
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
  end

  def update
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      redirect_to posts_path
      flash[:notice] = "編集が完了しました"
    else
      render 'edit'
    end

  end

  def destroy
    @post.destroy
    redirect_to posts_path
    flash[:notice] = "投稿を削除しました"
  end


  private

  def post_params
    params.require(:post).permit(:end_user_id, :view_image, :title, :body, :nation, :prefecture, :place)
  end

  def ensure_correct_end_user
    @post = Post.find(params[:id])
    unless @post.end_user == current_end_user
      redirect_to posts_path
    end
  end

  def ensure_guest_end_user
    if current_end_user.name == "guestenduser"
      redirect_to posts_path, notice: 'ゲストユーザーではご利用いただけません'
    end
  end

end
