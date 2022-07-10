class Public::TagsController < ApplicationController
  def index
    @end_user = EndUser.where("is_deleted = false")
    @posts = Post.where(end_user: @end_user)
    tags = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').pluck(:tag_id))
    # groupメソッド:指定したカラムtag_idのレコードの種類ごとにデータをまとめる
    @tags = Kaminari.paginate_array(tags).page(params[:page]).per(30)
    # Kaminari.paginate_array(配列)でオブジェクト扱いになりpageが使用可能
  end

  def show
    @tag = Tag.find(params[:id])
    @end_user = EndUser.where("is_deleted = false")
    @posts = @tag.posts.page(params[:page]).per(15).where(end_user_id: @end_user).order(created_at: :desc)
  end
end
