source 'https://rubygems.org'

gem 'rails', '3.2.11' #, :git => 'git://github.com/rails/rails.git'
gem 'bootstrap-sass' , "~> 2.0.4.0" # https://github.com/thomas-mcdonald/bootstrap-sass/
gem 'simple_form'                  # https://github.com/plataformatec/simple_form
gem 'seer', '0.10.0' , :git => 'https://github.com/OLEGB2012/seer'   # https://github.com/Bantik/seer 

#gem 'active_scaffold'
gem 'rails_admin'                  # https://github.com/sferik/rails_admin 
                                   # https://github.com/gregbell/active_admin/wiki/How-to-work-with-will_paginate

gem 'validates_timeliness' # https://github.com/adzap/validates_timeliness/

gem 'bcrypt-ruby'
gem 'faker'
gem 'will_paginate'            # https://github.com/mislav/will_paginate
gem 'bootstrap-will_paginate'  # https://github.com/yrgoldteeth/bootstrap-will_paginate

gem 'devise'
gem 'russian', '~> 0.6.0' # см. https://github.com/yaroslav/russian

group :development, :test do
  gem 'rspec-rails', '2.10.1'
  #gem 'sqlite3'
  gem 'pg'
  gem 'annotate'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails' ,   '3.2.5'
  gem 'coffee-rails' , '3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer' , '0.10.2', :platform => :ruby
  
  gem "uglifier", "~> 1.3.0"
end

gem 'jquery-rails'
#gem 'jquery-ui-rails'
#gem 'jquery-ui-themes'          # https://github.com/fatdude/jquery-ui-themes-rails (см. там же список имён тем)
#gem 'jquery-ui-bootstrap-rails' # https://github.com/jaimie-van-santen/jquery-ui-bootstrap-rails

group :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  # Use unicorn as the app server
  gem 'unicorn'
  gem 'fastercsv'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

group :development do
  # Deploy with Capistrano
  gem 'capistrano'
  #gem 'rvm-capistrano'  
end

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
