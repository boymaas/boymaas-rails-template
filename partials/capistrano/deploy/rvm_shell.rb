# Since we are using rvm to do our package managements, keep
# our environments clean and tidy and not mess with the global
# environment, we need to configure capistrano to use RVM
#
# since setup is able to run without RVM installed (since it can install .rvm if not avaliable)
# we unset the rvm shell only before deploy:setup
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.8.7'
set :rvm_type, :user
