require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module Udzilla
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    #videos for action text config
    config.after_initialize do
      ActionText::ContentHelper.allowed_attributes.add 'style'
      ActionText::ContentHelper.allowed_attributes.add 'controls'

      ActionText::ContentHelper.allowed_tags.add 'video'
      ActionText::ContentHelper.allowed_tags.add 'source'
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
