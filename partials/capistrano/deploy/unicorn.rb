# unicorn defaults
set :unicorn_worker_processes, 1      unless exists?(:unicorn_worker_processes)
set :unicorn_socket_name, "unicorn"   unless exists?(:unicorn_socket_name)

after "deploy:setup",   "unicorn:build_configuration"
after "deploy:symlink", "unicorn:link_configuration_file"

# to signal the unicorn master
def signal_pid(signal, pid_file)
  run "[[ -f #{ pid_file } ]] && (cat #{pid_file} | xargs kill -#{signal});true"
end

namespace :unicorn do
  desc "Generates a unicorn configuration file"
  task :build_configuration, :roles => :app do
    erb_config = File.read('config/deploy/support/unicorn.rb.erb')
    put ERB.new(erb_config).result(binding), shared_configuration_location_for(:unicorn, :rb)
  end
  desc "Links the configuration file"
  task :link_configuration_file, :roles => :app do
    run "ln -nsf #{shared_configuration_location_for(:unicorn, :rb)} #{public_configuration_location_for(:unicorn, :rb)}"
  end

  task :start, :roles => :app do
    run "cd #{current_path} && bundle exec unicorn_rails -c #{shared_configuration_location_for(:unicorn, :rb)} -E #{stage} -D"
  end

  task :stop, :roles => :app do
    # do a quit to the master
    signal_pid(:QUIT, shared_pid_for(:unicorn))
  end

  task :restart, :roles => :app do
    # do a usr2 to the master, unicorn configuration will 
    # take care of the rest
    signal_pid(:USR2, shared_pid_for(:unicorn))
  end
end

# Hook our unicorn server into
# the deploy namespace

namespace :deploy do

  %w(start stop restart).each do |action|
    desc "#{action} our server"
    task action.to_sym do
      find_and_execute_task("unicorn:#{action}")
    end
  end

end
