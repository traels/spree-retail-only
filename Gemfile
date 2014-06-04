source 'https://rubygems.org'

gem 'spree', '~>2.2'

# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-2-stable'
#gem 'protected_attributes'

group :test do
  gem 'therubyracer', :platforms => :ruby
  gem 'capybara'
  gem 'capybara-screenshot', :require => false
  gem 'selenium-webdriver'
  gem 'factory_girl_rails', '~> 4.2'
  gem 'rspec-rails', '~> 2.14.2'
end

gemspec
