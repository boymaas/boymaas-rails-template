# PRODUCTION-specific deployment configuration
# please put general deployment config in config/deploy.rb

# Nginx settings
set :nginx_port, '80'

# Unicorn settings
set :unicorn_worker_processes, 16

# remote user settings, and no sudo
set :user, "kgn-production"

set :mysql_user, 'kgn_production'
set :mysql_database, 'kgn_production'
set :mysql_password, 'vV]thHMO'

# Location
set :deploy_to, "/home/kgn-production"
