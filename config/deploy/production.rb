set :unicorn_rack_env, 'production'
set :rails_env, 'production'

role :web, %w{ec-trip-pro-webapp1}
role :app, %w{ec-trip-pro-webapp1}
role :db,  %w{ec-trip-pro-webapp1}