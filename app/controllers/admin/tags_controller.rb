class Admin::TagsController < ApplicationController

  def index
    @tags = Tag.page(params[:page]).per(30).order(created_at: :desc)
  end
end
