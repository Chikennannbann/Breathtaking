class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = locale
    # アプリの設定を反映
  end

  def locale
    @locale ||= params[:locale] ||= I18n.default_locale
    # パラメータで受け取った言語をインスタンス変数へ
    # パラメータがない場合はデフォルトの言語を使用(jaを設定済)

  end

  def default_url_options(options={})
    options.merge(locale: locale)
    # 画面遷移した時に言語の設定が消えないようにする
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
