source 'http://rubygems.org'

gem 'rails', '3.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

# Use unicorn as the web server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
#gem 'ruby-debug'
gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

#gem "authlogic"
#will need to fix this when Authlogic gem is fix
gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem "haml"

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  #gem 'webrat'
  #gem "rspec", :require => 'spec'
  gem "rspec-rails", ">= 2.0.0.beta.22"
  gem "shoulda"
  #gem "cucumber"
  #gem "cucumber-rails"    
  #gem "factory_girl"
  gem "factory_girl_rails"
  gem "test-unit", "~> 1.2.3"
  gem 'jquery-rails'
end
