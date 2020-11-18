source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'active_record_union'
gem 'aws-sdk-s3', require: false
gem 'bcrypt'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
# FIXME: https://github.com/doorkeeper-gem/doorkeeper/issues/1412
gem 'doorkeeper', '~> 5.3.0'
gem 'friendly_id'
gem 'gibbon'
gem 'jsonapi-serializer'
gem 'kaminari'
gem 'lograge'
gem 'mailgun-ruby', '~> 1.1.6'
gem 'metainspector', '~> 5.9.0'
gem 'onesignal-ruby', github: 'mikamai/onesignal-ruby', branch: 'develop'
gem 'paranoia'
gem 'pg', '~> 0.18.4'
gem 'pg_search'
gem 'premailer-rails'
gem 'puma', '~> 4.1'
gem 'rack-cors'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'remote_syslog_logger'
gem 'sentry-raven'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'skylight'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'letter_opener_web', '~> 1.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd'
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
