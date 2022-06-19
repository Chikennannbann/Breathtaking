class Admin::PostCommentsController < ApplicationController

  def destroy
    @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
  end
end
