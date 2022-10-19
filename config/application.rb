require_relative "boot"
require "roo"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Project1
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.action_view.preload_links_header = false

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Central Time (US & Canada)"
    config.eager_load_paths << Rails.root.join("extras")
    config.assets.paths << Rails.root.join("app/assets/fonts")
    config.action_dispatch.rescue_responses
          .merge!("CanCan::AccessDenied" => :unauthorized)
    config.middleware.insert_before 0, Rack::Cors do
      allow do
          origins "*"
          resource "*", headers: :any, :methods => [:get, :post, :patch, :put, :delete, :options ]
      end
    end
  end
end
