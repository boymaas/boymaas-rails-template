before 'deploy:setup', 'deploy:unset_rvm_shell'
namespace :deploy do
  task :unset_rvm_shell do
     set :default_shell, 'sh'
  end
end
