class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!, except: [:show]
  before_action :ensure_correct_end_user, only: [:edit, :update]
  before_action :ensure_guest_end_user, only: [:edit]

  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts.page(params[:page]).per(9).order(created_at: :desc)
    @groups = @end_user.groups
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path
      flash[:notice] = "ユーザー情報を更新しました"
    else
      render 'edit'
    end
  end

  def unsubscribe
  end

  def withdraw
    @end_user = current_end_user
    @end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
    flash[:notice] = "退会しました。ご利用いただきありがとうございました！"
  end

  def favorites
    @end_user = EndUser.find(params[:id])
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:post_id)
    @favorite_posts = Kaminari.paginate_array(Post.find(favorites)).page(params[:page]).per(9)
    # Kaminari.paginate_array(配列)でオブジェクト扱いになりpageが使用可能
  end


  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image, :is_deleted)
  end

  def ensure_correct_end_user
    @end_user = EndUser.find(params[:id])
    unless @end_user == current_end_user
      redirect_to end_user_path(current_end_user)
    end
  end

  def ensure_guest_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.name == "ゲストユーザー"
      redirect_to end_user_path(current_end_user), notice: 'ゲストユーザーはプロフィール編集画面へは遷移できません。'
    end
  end
end
