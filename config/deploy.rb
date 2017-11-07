# config valid only for current version of Capistrano
lock "3.8.2"

set :application, "ec-trip"
set :repo_url, "github:yamataka22/EC-TRIP.git"

# Default branch is :master
ask :branch, "master"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/ec-trip"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('.env')

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'vendor/assets/bower_components', 'public/system', 'public/assets')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rbenv_ruby, '2.4.1'

set :delayed_job_workers, 1
set :delayed_job_roles, [:app]

namespace :bower do
  task 'install' do
    on roles(:web) do
      within release_path do
        execute :rake, 'bower:install'
      end
    end
  end
end
before 'deploy:updated', 'bower:install'

set :unicorn_config_path, "#{release_path}/config/unicorn.rb"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end
  after :publishing, :restart
end
