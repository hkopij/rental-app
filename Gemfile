source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors', require: 'rack/cors'
gem 'bcrypt', '~> 3.1.7'
gem 'knock', '1.4.2'
gem 'active_model_serializers'

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
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails', '~> 4.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
