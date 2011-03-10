desc "Runs a rake task on remote servers"
task :rake do
  run "cd current && RAILS_ENV=#{stage} bundle exec rake #{ENV['TASK']}"
end
