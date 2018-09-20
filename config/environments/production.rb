Peatio::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true
  config.eager_load = true

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.assets.compile = true
  config.assets.precompile += ['*.js', '*.css', '*.css.erb', '*.js.coffee']
  #config.assets.precompile = ['*.js', '*.css', '*.css.erb', '*.js.coffee']
  config.assets.digest = false
  #config.assets.version = '1.0'

  config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Use a different cache store in production.
  # config.cache_store = :file_store, "tmp"
  config.cache_store = :redis_store, ENV['REDIS_URL']

  config.session_store :redis_store, :key => '_peatio_session', :expire_after => ENV['SESSION_EXPIRE'].to_i.minutes

  config.assets.precompile += %w( funds.js market.js withdraws_controller.js.coffee events.js.coffee market.css admin.js admin.css html5.js api_v2.css api_v2.js .svg .eot .woff .ttf )

  # Don't care if the mailer can't send.
  config.action_mailer.default_url_options = { host: ENV["URL_HOST"], protocol: ENV['URL_SCHEMA'] }

  config.action_mailer.raise_delivery_errors = false

  config.assets.js_compressor = Uglifier.new(:mangle => false)

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  address:              'auth.smtp.1and1.co.uk',
  port:                 '587',
  domain:               'tradenaira.com',
  user_name:            'support@tradenaira.com',
  password:             'f*//ishc&nt',
  authentication:       'login',
  enable_starttls_auto: true  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.active_record.default_timezone = :local

  config.exceptions_app = self.routes

  require 'middleware/i18n_js'
  require 'middleware/security'
  config.middleware.insert_before ActionDispatch::Static, Middleware::I18nJs
  config.middleware.insert_before Rack::Runtime, Middleware::Security
  
end
