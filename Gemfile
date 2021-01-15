# frozen_string_literal: true

source 'https://rubygems.org'

# Heroku uses the ruby version to configure your application"s runtime.
ruby '2.7.0'

# Back-endy
gem 'bootsnap', require: false
gem 'puma'
gem 'rack-canonical-host'
gem 'rack-timeout'
gem 'sinatra'

# data
gem 'clearbit'
gem 'plaid'

group :development, :test do
  gem 'dotenv'
  gem 'rspec'
  gem 'rspec-its'
  gem 'rspec_junit_formatter'
  gem 'rubocop', require: false
end

group :test do
  gem 'rack-test'
  gem 'simplecov'
end
