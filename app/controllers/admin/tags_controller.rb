class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.page(params[:page]).per(30).order(created_at: :desc)
  end
end
