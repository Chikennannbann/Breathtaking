class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.page(params[:page]).order(created_at: :desc)
  end

  def show
    @group = Group.find(params[:id])
  end

end
