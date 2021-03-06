require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Magic
  class Application < Rails::Application
    # Configure Browserify to use babelify to compile ES6
    config.browserify_rails.commandline_options = "-t [ babelify --presets [ react es2015 ] ]"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
