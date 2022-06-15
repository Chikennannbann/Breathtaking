class Public::GroupsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index]
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_end_user, except: [:index, :show]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def join
    @group = Group.find(params[:group_id])
    @group.end_users << current_end_user
    redirect_to groups_path
    flash[:notice] = "グループに参加しました"
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    @group.end_users << current_end_user
    if @group.save
      redirect_to groups_path
      flash[:notice] = "グループを作成しました"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
      flash[:notice] = "グループ情報を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
    flash[:notice] = "グループを削除しました"
  end

  def withdraw
    @group = Group.find(params[:group_id])
    @group.end_users.delete(current_end_user)
    redirect_to groups_path
    flash[:notice] = "グループから脱退しました"
  end


  private

  def group_params
    params.require(:group).permit(:name, :caption, :destination, :date, :owner_id, :group_image)
  end

  def ensure_correct_end_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_end_user.id
      redirect_to groups_path
    end
  end

  def ensure_guest_end_user
    if current_end_user.name == "guestenduser"
      redirect_to groups_path, notice: 'ゲストユーザーではご利用いただけません'
    end
  end
end