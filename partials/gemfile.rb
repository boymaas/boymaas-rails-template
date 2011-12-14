# Set up Gemfile

puts "Creating Gemfile ...".magenta

remove_file 'Gemfile'
file 'Gemfile', <<-RUBY.gsub(/^ {2}/, '')

  # Gems host
  source :gemcutter
  #source "http://rubygems.com"
  source "http://gems.github.com"

  # Rails (version >= 3.0.4 and < 3.1)
  gem 'rails', '~> 3.0.4'

  # Database
  gem 'mysql'

  # Deployment manager
  gem 'capistrano'

  # HTML and CSS replacement (includes SASS)
  gem 'haml', '~> 3.0'
  gem 'haml-rails'

  # HTML/CSS framework and boilerplate
  gem 'compass', '>= 0.10.6'
  gem 'html5-boilerplate'

  # Simple form
  gem "simple_form"

  # Human readable URLs
  gem 'friendly_id', '~> 3.2'
  gem 'babosa'

  # Validation of associations
  gem 'validates_existence', '~> 0.5'

  # Pagination of long lists
  gem 'will_paginate', '~> 3.0.pre2'

  # User authentication (accounts)
  gem 'devise', '~> 1.1'

  # For Devise view generation
  gem 'hpricot'
  gem 'ruby_parser'

  # For coffescript
  gem 'json'
  gem 'barista'
  gem 'coffee-script-source'

  # File upload management
  gem 'paperclip', '~> 2.3.8'
  
  # Optional gems below:

  # User authorization (permissions)
  # gem 'cancan', '~> 1.5.1'

  # To convert Markdown to HTML
  # gem 'kramdown', '~> 0.13'

  # To deal with file uploads via Flash uploader
  # gem 'mime-types'

  # To track changes to pages and other objects
  # gem 'vestal_versions'
  #    -or-
  # gem 'paper_trail'

  group :development, :test do
    gem 'capybara'
    gem "capybara-envjs"
    gem 'database_cleaner'
    gem "cucumber-rails"
    gem "rspec-rails"
    gem "launchy"
    gem "selenium-webdriver"
    #gem "autotest-rails"
    gem "shoulda"
    gem "machinist"
    gem "faker"
    gem "ruby-debug"
    # development tools
    gem "rails-erd"
    gem "wirble"
    gem "awesome_print"
    gem "hirb"
    
  end
    
RUBY

# Bundle will be installed in the rvm partial

