source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'json'
gem 'pg'
gem 'unicorn'
gem 'rails_admin', :git => "git://github.com/sferik/rails_admin.git"
gem 'will_paginate', '~>3'
gem 'helpful_fields'
gem 'url_store'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'bootstrap-sass', '>=1.3'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

group :development do
  gem 'heroku', :require => false
  gem 'spork', '0.9.0.rc9', :require => false
end

group :development, :test do
  gem 'rspec-rails', :require => false
end

group :test do
  gem 'email_spec'
  gem 'factory_girl_rails'
  gem 'delorean'
  gem 'capybara'
  gem 'launchy'
end
