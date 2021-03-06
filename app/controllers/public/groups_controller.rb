class Public::GroupsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index]
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_end_user, except: [:index, :show]

  def index
    session[:title] = nil
    session[:body] = nil
    @end_user = EndUser.where("is_deleted = false")
    @groups = Group.page(params[:page]).where(owner_id: @end_user).where("date > ?", Date.today).order(created_at: :desc)
    # where("date > ?", Date.today)で今日以前に開催のイベント用グループは表示されない
  end

  def show
    @group = Group.find(params[:id])
    @end_user = @group.owner
  end

  def join
    @group = Group.find(params[:group_id])
    @group.end_users << current_end_user
    redirect_to group_path(@group), notice: t('notice.group_join')
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    @group.end_users << current_end_user
    if @group.save
      redirect_to groups_path, notice: t('notice.group_new')
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: t('notice.group_update')
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: t('notice.group_delete')
  end

  def withdraw
    @group = Group.find(params[:group_id])
    @group.end_users.delete(current_end_user)
    redirect_to group_path(@group), notice: t('notice.group_withdraw')
  end

  private

  def group_params
    params.require(:group).permit(:name, :caption, :destination, :date, :owner_id, :group_image)
  end

  def ensure_correct_end_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_end_user.id || current_end_user.name == "ゲストユーザー"
      redirect_to groups_path
    end
  end

  def ensure_guest_end_user
    if current_end_user.name == "ゲストユーザー"
      redirect_to groups_path, notice: t('notice.guest_alert')
    end
  end
end
