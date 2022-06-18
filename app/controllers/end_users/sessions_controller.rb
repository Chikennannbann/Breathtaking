class EndUsers::SessionsController < Devise::SessionsController

  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to posts_path
    flash[:notice] = "ゲストユーザーでログインしました"
  end
end