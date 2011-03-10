# this option will run commands in a tty, this is needed for 
# sudo prompt
default_run_options[:pty] = true

# Deployment details
set :user,   "deploy"      unless exists?(:user)
#set :runner, user          unless exists?(:runner)

# Our Server Roles
role :app, domain.to_s
role :web, domain.to_s
role :db,  domain.to_s, :primary => true

# Paths
set :shared_config_path,   "#{shared_path}/configs"
set :shared_sockets_path,  "#{shared_path}/sockets"
set :shared_pids_path,     "#{shared_path}/pids"

after "deploy:setup", "deploy:build_dirs"
namespace :deploy do
  desc "Build needed dirs"
  task :build_dirs, :role => :app do
    [shared_config_path, shared_sockets_path, shared_pids_path].each do |path|
      run "mkdir -p #{path}"
    end
  end
end

# Always cleanup old releases
set :keep_releases, 4      unless exists?(:keep_releases)
after "deploy:update", "deploy:cleanup"

# Our helper methods

def public_configuration_location_for(server = :thin, ext = 'yml')
  "#{current_path}/config/#{server}.#{ext}"
end

def shared_configuration_location_for(server = :thin, ext = 'yml')
  "#{shared_config_path}/#{server}.#{ext}"
end

def shared_pid_for(process)
  "#{shared_pids_path}/#{process}.pid"
end
def shared_socket_for(process)
  "#{shared_sockets_path}/#{process}.socket"
end

