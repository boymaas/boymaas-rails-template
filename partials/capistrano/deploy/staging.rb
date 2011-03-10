# STAGING-specific deployment configuration
# please put general deployment config in config/deploy.rb
# Nginx settings
set :nginx_port, '8080'

# Unicorn settings
set :unicorn_worker_processes, 1

# remote user settings, and no sudo
set :user, "kgn-staging"
set :rails_env, "staging"

set :mysql_user, 'kgn_staging'
set :mysql_database, 'kgn_staging'
set :mysql_password, 'G2F1rPhr'
set :mysql_test_database, 'kgn_test'

# Location
set :deploy_to, "/home/kgn-staging"

# generic deploy script
load 'config/deploy'
