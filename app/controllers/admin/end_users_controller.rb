class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to admin_end_user_path(@end_user.id)
    else
      render 'edit'
    end
  end


  private

  def end_user_params
    params.require(:end_user).permit(:name, :email, :introduction, :profile_image, :is_deleted)
  end

end
