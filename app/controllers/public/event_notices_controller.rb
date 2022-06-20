class Public::EventNoticesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user
  before_action :ensure_guest_end_user, except: [:index, :show]

  def new
    @group = Group.find(params[:group_id])
  end

  def create
    @group = Group.find(params[:group_id])
    @title = params[:group][:title]
    @body = params[:group][:body]
    # グループでtitle, bodyを扱う
    session[:body] = @body
    session[:title] = @title
    # 一時的に保存する記述, groups/indexを経由すると削除されるように設定している。
    # 保存が必要な場合にはnotificationモデルなどでテーブル作成が必要。

    event = {
      :group => @group,
      :title => @title,
      :body => @body
    }

    ContactMailer.send_notifications_to_group(event)

    redirect_to group_sent_path(@group)
  end

  def sent
    @title = session[:title]
    @body = session[:body]
  end


  private

  def ensure_correct_end_user
    @group = Group.find(params[:group_id])
    unless @group.owner_id == current_end_user.id || current_end_user.name == "ゲストユーザー"
      redirect_to groups_path
    end
  end

  def ensure_guest_end_user
    if current_end_user.name == "ゲストユーザー"
      redirect_to groups_path, notice: 'ゲストユーザーではご利用いただけません'
    end
  end
end
