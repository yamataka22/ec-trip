source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.3'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'dotenv-rails', '~> 2.1.1'
gem 'devise', '~> 4.3.0'
gem 'omniauth-oauth2', '~> 1.4.0'
gem 'omniauth-twitter', '~> 1.4.0'
gem 'omniauth-facebook', '~> 4.0.0'
gem 'rails-i18n', '~> 4.0.1'
gem 'paperclip', '~> 5.2.1'
gem 'aws-sdk', '~> 2.9.18'
gem 'stripe', '~> 2.8.0'
gem 'kaminari', '~> 1.0.1'
gem 'tinymce-rails', '~> 4.6.1'
gem 'tinymce-rails-imageupload', '~> 4.0.0.beta'
gem 'tinymce-rails-langs'
gem 'delayed_job_active_record', '~> 4.1.1'
gem 'daemons', '~> 1.2.4'
gem 'enum_help', '~> 0.0.17'
gem 'active_hash', '~> 1.5.2'
gem 'bower-rails'
gem 'bootstrap', '~> 4.0.0.beta2'
gem 'haml-rails'
gem 'httpclient'

group :production do
  gem 'unicorn', '~> 5.3.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'rspec-rails', '~> 3.6'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'capybara', '~> 2.14'
  gem 'factory_girl_rails', '~> 4.8'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # 高機能コンソール
  gem 'pry-rails'

  # デバッガー
  gem 'pry-byebug'
  gem 'pry-stack_explorer'

  # pryの入出力に色付け
  gem 'pry-coolline'
  gem 'awesome_print'

  # PryでのSQLの結果を綺麗に表示
  gem 'hirb'
  gem 'hirb-unicode'

  gem 'erb2haml'

  # Capistrano
  gem 'capistrano', '~> 3.8.1'
  gem 'capistrano-bundler', '~> 1.2.0'
  gem 'capistrano-rails', '~> 1.2.3'
  gem 'capistrano-rbenv', '~> 2.1.1'
  gem 'capistrano3-unicorn', '~> 0.2.1'
  gem 'capistrano3-delayed-job', '~> 1.7.3'
  gem 'capistrano-bower', '~> 1.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
