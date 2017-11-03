require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EcTrip
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja

    # field_with_errors回避
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec
      g.controller_specs false
      g.view_specs false
    end

    # active_job
    config.active_job.queue_adapter = :delayed_job
  end
end
