source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'haml-rails', '~> 1.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'high_voltage', '~> 3.0.0'
gem 'devise'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'thin'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'pry', '~> 0.10.4'
end

group :development, :test do
  gem 'pry-nav'
  gem 'rspec-rails', '~> 3.5'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'faker', '~> 1.7', '>= 1.7.3'
  gem 'selenium-webdriver', '~> 3.4', '>= 3.4.3'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'chromedriver-helper'
  gem 'vcr'
  gem 'rails-controller-testing'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
