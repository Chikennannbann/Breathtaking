require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Breathtaking
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Tokyo'

    config.i18n.available_locales = %i(ja en)
    # 有効にする言語のホワイトリスト
    config.i18n.enforce_available_locales = true
    # ホワイトリストをチェックするか
    config.i18n.default_locale = :ja
    # 言語を指定されなかった場合のデフォルト値
    # config.eager_load_paths << Rails.root.join("extras")

  end
end
