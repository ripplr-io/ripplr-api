source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'analytics-ruby'
gem 'active_record_union'
gem 'aws-sdk-s3', require: false
gem 'bcrypt'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'cancancan'
gem 'counter_culture'
gem 'devise'
gem 'doorkeeper', '~> 5.5'
gem 'feedjira'
gem 'friendly_id'
gem 'httparty'
gem 'interactor'
gem 'jsonapi-serializer'
gem 'kaminari'
gem 'lograge'
gem 'onesignal-ruby', github: 'jongirard/onesignal-ruby', branch: 'develop'
gem 'paranoia'
gem 'pg'
gem 'pg_search'
gem 'puma', '~> 4.3'
gem 'rack-cors'
gem 'rails', '~> 6.1.0'
gem 'remote_syslog_logger'
gem 'sentry-raven'
gem 'sendgrid-ruby'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'skylight'
gem 'slack-notifier'
gem 'stripe'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'rails-erd'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'webmock'
end

group :test do
  gem 'rspec-rails', '~> 4.0'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
