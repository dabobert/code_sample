source 'https://rubygems.org'

gem 'rails', '4.1.0'

# Bundle edge Rails instead:
gem "random_data", "~> 1.6.0" #allows to easily create random date, like Random.email or Random.last
gem "wicked_pdf", "1.1.0" #allows dynamic pdf generation. requires wicked_pdf runtime on server. check initilizer for location
gem 'has_secure_token' #Create uniques random tokens for any model in ruby on rails. Backport of ActiveRecord::SecureToken 5 to AR 3.x and 4.x
gem 'mysql2', "0.3.21"
gem 'aws-s3', :git => 'git://github.com/bartoszkopinski/aws-s3'# , '0.6.3', :require => 'aws/s3'
gem 'aws-sdk', '~> 2' #The official AWS SDK for Ruby. http://aws.amazon.com/sdkforruby
gem 'geokit', '1.7.1'
gem 'geokit-rails'
gem 'version_sorter', '~> 2.0' #VersionSorter is a C extension that does fast sorting of large sets of version strings.
gem 'httparty', '0.10.0' #updated version of http ie over 0.7.6 make the brand and other clients work
gem "mixpanel_client", "~> 3.0.0" #client for retrieving data from the mixpanel api
gem "mixpanel-ruby", "~> 1.2.0" #inserting data into mixpanel, mainted by mixpanel
gem 'activerecord-session_store' #for cookie overflow error http://www.railsbling.com/2013/01/08/cookieoverflow-in-rails-4/
gem 'hominid'
gem 'airbrake'#, '~> 4.1.0' #send staging/production application errors to airbrake
gem 'thinking-sphinx', '3.1.0', :require => 'thinking_sphinx'
#joiner fixes an issue in thinking sphinx with rails 4.1
# gem 'joiner', '~> 0.3.4'#Builds ActiveRecord outer joins from association paths and provides references to table aliases.
gem 'gon', '~> 6.0', '>= 6.0.1' # If you need to send some data to your js files and you don't want to do this with long way trough views and parsing - use this force!
gem "ruby-saml", "~> 0.6.0" #powers one-login for gensler
gem 'bulk_insert', '~> 1.6' # Efficient bulk inserts with ActiveRecord. Used with AEC/BlueBook
gem "XMLCanonicalizer", "~> 1.0.1" #needed for one-login for gensler
gem 'json'
gem 'geocoder', '~> 1.3', '>= 1.3.7' #geocoder. provides data for aec
gem 'fog', '~> 1.19.0'
gem "mailchimp", "~> 0.0.8"
gem 'will_paginate'
gem 'amatch', '0.2.5'
gem "oj" #The fastest JSON parser and object serializer.
gem 'string-scrub' #automatically replaces invalid encoding characters
gem 'money-rails' #Integration of RubyMoney - Money with Rails
gem 'RedCloth'
gem 'tamtam', '0.0.3'
gem 'mechanize', '2.7.2'
gem 'patron', '0.10.0'
gem 'activerecord-import'
gem 'hpricot', '0.8.3'
gem 'zeroclipboard-rails' #(adds to asset pipleline) provides an easy way to copy text to the clipboard using an invisible Adobe Flash movie and a JavaScript interface. 
gem 'imagga', :git => 'git://github.com/designerpages/imagga-v2.git' #client for imagga services
#gem 'RubyInline', '3.8.6'
gem 'public_suffix' #Domain Name parser based on the Public Suffix List
gem 'memcached', '~> 1.8'
gem 'haml'
gem "doorkeeper", "~> 0.7.2" #oauth provider powered by devise
gem "rjson", "~> 0.1.5" #templating for json
gem "rest-client", "~> 1.6.7"
gem "rake", '>= 10.0.03' #otherwise you risk having differnet version developers and different servers with different versions which is bad
gem 'foreigner'
gem 'hashie'
#moved the gem 'acts_as_tree' functionality into the category module. category is the only model that is uses it and its a pretty lightweight gem
gem 'carrierwave', '0.9.0' # 0.5.8 or up causes this error https://github.com/rspec/rspec-core/issues/313
gem 'file_validators' # Carrierwave validator for file size
gem 'acts_as_commentable'
gem 'sailthru-client', '~> 4.0.1', :require => 'sailthru' #allows mail to be sent through sailthru service
gem 'prototypal_attribute', :git => 'git://github.com/designerpages/prototypal_attribute.git'
gem 'permalink_fu'
gem 'therubyracer', '0.12.3'
gem 'execjs'
gem 'mongo'
gem 'bson_ext'
gem 'mini_magick', '3.5' #there's an issues with v3.7 https://github.com/carrierwaveuploader/carrierwave/issues/1282
gem 'resque', '1.25.1', :require => 'resque/server'
gem 'ts-resque-delta', '~> 2.0.0' #allows thinking sphinx queue delta updates to be queued up
gem 'devise', '3.2.2'
gem 'devise-encryptable'
gem 'carmen-rails', '~> 1.0.0', :git => 'git://github.com/designerpages/carmen-rails'
gem 'jquery-rails', "3.0.4"
gem 'jquery-ui-rails'#, "4.1.1"
gem 'acts-as-taggable-on', '4.0.0' #A tagging plugin for Rails applications that allows for custom tagging along dynamic contexts.
gem 'inherited_resources'
gem 'has_scope'
gem 'awesome_print'
gem 'cancan'
gem 'foreman'
gem 'pjax_rails'
gem "acts_as_list", "~> 0.2.0"
# remove with rails 5
gem 'backport_new_renderer', '~> 1.0'  #Backport render anywhere feature from rails 5
#gem 'dropzonejs-rails' #drag and drop upload
gem 'rubyzip', '~> 1.1.6'
gem 'rails-observers'
gem 'ancestry' #used to nest project_products by providing a parent_id and many convenience methods
gem 'elasticsearch-rails', "~> 5.0"
gem 'elasticsearch-model', "~> 5.0"
gem 'react-rails', "2.4.3"
gem 'flux-rails-assets'  #Use Facebook's Flux dispatcher and Node EventEmitter in your Rails project.
gem 'axios_rails'  #Adds Axios into your Rails app.
gem 'liquid', '~> 3.0', '>= 3.0.6' #A secure, non-evaling end user template engine with aesthetic markup.

group :cucumber do
  gem 'gherkin', '2.4.6'
  gem 'cucumber', '0.10.7'
  gem 'cucumber-rails', '0.3.2', :require => false
#  gem 'launchy', '0.3.3'
end

# group :cucumber, :test do
#   #gem 'no_peeping_toms', :git => 'https://github.com/patmaddox/no-peeping-toms.git'
#   gem 'factory_girl', '~> 2.5', :require => false
#   gem 'factory_girl_rails'
#   gem 'shoulda'
#   gem 'shoulda-addons'
#   gem 'rr'
#   gem 'vcr', :require => false
#   gem 'webmock', :require => false
# end


group :development, :test  do
  # gem 'xray-rails' #shows what code comes from which partial/view
  # gem 'rspec-rails', '~> 3.4', '>= 3.4.2' #rspec-rails is a testing framework for Rails 3.x and 4.x.
  # gem 'rspec-its', '~> 1.2' #RSpec::Its provides the its method as a short-hand to specify the expected value of an attribute.
  # gem 'capybara-webkit'
  # gem 'rspec'
  gem 'database_cleaner', :require => false
  gem 'quiet_assets' #Mutes assets pipeline log messages
  gem 'faker'
  # gem 'unicorn'
  gem 'thin', '1.7.0'
  gem 'capistrano', '2.13.5'
  gem "better_errors"
  gem 'binding_of_caller'
  gem 'pry'
  gem 'ruby-prof' #a code profiler for MRI rubies
  ###Useful tools but HEAVY may want to comment these out
  # gem 'bullet' #help to kill N+1 queries and unused eager loading.
  # gem 'fozzie' #make statistics sending from Ruby applications simple and efficient as possible. Currently supports Statsd, and is inspired by the original ruby-statsd gem by Etsy.
  # gem 'request-log-analyzer' #Request log analyzer's purpose is to find out how your web application is being used, how it performs and to focus your optimization efforts
  # gem 'rails_view_annotator' #makes it easy to find out which partial generated which output
  # gem 'active_record_query_trace' #logs sources of SQL queries to Rails log  
end

gem 'sass-rails', '4.0.5' #Sass adapter for the Rails asset pipeline.
gem 'coffee-rails', '~> 4.1', '>= 4.1.1' #CoffeeScript adapter for the Rails asset pipeline.
gem 'uglifier', '>= 1.3.0'

#Gems needed for JPG converter library html to image
#gem 'wkhtmltoimage-binary', '0.12.2'
#gem 'imgkit', '1.6.1'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'
