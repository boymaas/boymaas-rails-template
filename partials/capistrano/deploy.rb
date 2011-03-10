# Generic deploy functionality setting up unicorn
# servers on a vps

load "config/deploy/setup_packages"
load "config/deploy/default_config_vars"
load "config/deploy/rvm_shell"
load "config/deploy/rvm_shell_disable_for_setup"
load "config/deploy/rvm_shell_install"
load "config/deploy/bundler"
load "config/deploy/unicorn"
load "config/deploy/nginx"
load "config/deploy/mysql"
#load "config/deploy/psql"
load "config/deploy/test"
load "config/deploy/rake"
load "config/deploy/background_fu"

