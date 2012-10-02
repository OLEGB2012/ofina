require 'bundler/capistrano'
#set :application, "ofina"
#set :scm, :git
#set :repository, "git://github.com/OLEGB2012/#{application}.git"
##set :repository, "git://github.com/Loremaster/sample_app.git"
#
#set :branch, "master" 
#server "localhost", :web, :app, :db, :primary => true
#ssh_options[:port] = 2222
##ssh_options[:keys] = "~/.vagrant.d/insecure_private_key"
#ssh_options[:keys] = "~/.ssh/id_rsa"
##ssh_options[:keys] = "~/.ssh/autherized_keys2"
#set :user, "deployer"
#set :group, "deployer"
#set :deploy_to, "/home/deployer/ofina"
#set :use_sudo, false
#set :deploy_via, :copy
#set :copy_strategy, :export

set :use_sudo, false 
#tell git to clone only the latest revision and not the whole repository 
set :git_shallow_clone, 1 
set :keep_releases, 5 
set :application, "ofina" 
set :user, "deployer" 
set :password, "deployer" 
set :deploy_to, "/home/deployer/#{application}" 
set :runner, "deployer" 
set :repository, "git://github.com/OLEGB2012/#{application}.git"
set :scm, :git 
set :real_revision, lambda { source.query_revision(revision) { |cmd| capture(cmd) } } #options necessary to make Ubuntu’s SSH happy 
ssh_options[:paranoid] = false
ssh_options[:port] = 2222
ssh_options[:keys] = "~/.ssh/id_dsa"
default_run_options[:pty] = true 
role :app, "localhost" 
role :web, "localhost" 
role :db, "localhost", :primary => true 

namespace :deploy do 
task :start do 
sudo "/etc/init.d/unicorn start" 
end 
task :stop do 
sudo "/etc/init.d/unicorn stop" 
end 
task :restart do
sudo "/etc/init.d/unicorn reload" 
end 
end 

#set :application, "set your application name here"
#set :repository,  "set your repository location here"

#set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
