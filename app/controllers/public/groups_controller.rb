class Public::GroupsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
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
end

