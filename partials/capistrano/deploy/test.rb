namespace :runtest do
  def run_in_current cmd
    run "cd current && (#{cmd})"
  end
  desc "Runs all tests"
  task :all, :role => :app do
    rspec
    cucumber
  end
  desc "Runs the rspec test on current in rails test environment"
  task :rspec, :role => :app do
    run_in_current "RAILS_ENV=test rake spec"
  end
  desc "Runs the cucumber test on current in rails test environment"
  task :cucumber, :role => :app do
    run_in_current "RAILS_ENV=test rake cucumber"
  end
end
