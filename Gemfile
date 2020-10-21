source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'pg', '~> 0.18.4'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'active_model_serializers'
gem 'active_record_union'
gem "aws-sdk-s3", require: false
gem 'bcrypt'
gem 'devise'
gem 'devise-jwt'
gem 'friendly_id'
gem 'kaminari'
gem "lograge"
gem 'logstash-logger'
gem 'mailgun-ruby', '~> 1.1.6'
gem 'metainspector', '~> 5.9.0'
gem 'onesignal-ruby', github: 'mikamai/onesignal-ruby', branch: 'develop'
gem 'rack-cors'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'skylight'
gem 'sentry-raven'

gem 'factory_bot_rails'
gem 'faker'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'letter_opener_web', '~> 1.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd'
end

group :test do
  gem 'rspec-rails', '~> 4.0'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
