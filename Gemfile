source 'https://rubygems.org'
ruby "2.1.5"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0.5'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg'
  gem 'rails_12factor', group: :production
end

group :test do
  gem 'cucumber-rails', '~> 1.4.2', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner', '~> 1.4.1'
  gem 'capybara', '~> 2.4.4'
  gem 'email_spec', '~> 1.6.0' # Testing emails with capybara
  gem 'shoulda-matchers', '~> 2.8.0' # Common unit test shortcuts with RSpec
  gem 'show_me_the_cookies', '~> 2.6.0' # Manipulating cookies for testing sessions with cucumber
  # gem 'selenium-webdriver', '~> 2.46.2'
  gem 'capybara-webkit', '~> 1.5.2' #Headless browser for javascript enabled tests
  gem 'factory_girl_rails', '~> 4.5.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.2.3'
end

group :development do
  gem 'better_errors', '~> 2.1.1'
  gem 'letter_opener', '~> 1.4.0' #Open emails in browser in development
end

gem 'chewy', '~> 0.8.1'
gem 'newrelic_rpm'
gem 'simple_form', '~> 3.1.0'
gem 'devise', '~> 3.5.1'
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 4.2.7'
gem 'activeadmin', '~> 1.0.0.pre1'
gem 'kaminari', '~> 0.16.3'

gem 'acts_as_list', '~> 0.7.2'
gem 'acts_as_commentable', '~> 4.0.2'
gem 'acts_as_votable', '~> 0.10.0'
gem 'acts-as-taggable-on', '~> 3.5.0'
gem 'impressionist', '~> 1.5.1' #Acts as viewable
gem 'public_activity', '~> 1.4.2'


