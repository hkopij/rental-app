# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'bcrypt', '~> 3.1.7'
gem 'date_validator'
gem 'knock', '1.4.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2'
gem 'rails_best_practices'
gem 'rubocop', '~> 0.73.0', require: false
gem 'simplecov', require: false, group: :test

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner', '~> 1.5.3'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'rspec-rails', '~> 3.8'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
