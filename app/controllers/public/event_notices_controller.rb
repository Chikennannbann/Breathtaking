class Public::EventNoticesController < ApplicationController
  before_action :authenticate_end_user!

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

end
