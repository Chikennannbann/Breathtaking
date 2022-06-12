class Public::EventNoticesController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
  end

  def create
    @group = Group.find(params[:group_id])
    @title = params[:title]
    @body = params[:body]

    event = {
      :group => @group,
      :title => @title,
      :body => @body
    }

    ContactMailer.send_notifications_to_group(event)

    redirect_to group_sent_path(@group)
  end

  def sent
    @title = params[:title]
    @body = params[:body]
  end

end
