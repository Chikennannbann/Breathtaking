class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index, :show]
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_end_user, except: [:index, :show]

  def index
    @end_user = EndUser.where("is_deleted = false")
    @posts = Post.page(params[:page]).per(15).where(end_user_id: @end_user).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @end_user = @post.end_user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).per(5)
    @post_tags = @post.tags
  end

  def new
    @post = Post.new
  end

  def create
    ActiveRecord::Base.transaction do
      @post = Post.new(post_params)
      @post.end_user_id = current_end_user.id
      tag_list = params[:post][:name].split('、')
      if
        @post.save
        @post.save_tags(tag_list)
        redirect_to posts_path, notice: t('notice.post_new')
      else
        render 'new'
      end
    end
  end

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      tag_list = params[:post][:name].split('、')
      if @post.update(post_params)
        @post.save_tags(tag_list)
        redirect_to posts_path, notice: t('notice.post_new')
      else
        render 'edit'
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: t('notice.post_delete')
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
    if current_end_user.name == "ゲストユーザー"
      redirect_to posts_path, notice: t('notice.guest_alert')
    end
  end
end
