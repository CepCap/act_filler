require_relative "boot"

require "active_model/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module ActFiller2
  class Application < Rails::Application
    config.load_defaults 6.1

  end
end
