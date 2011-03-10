namespace :deploy do

  # "Run this after every successful deployment" 
  task :after_default do
    restart_background_fu
  end

end

desc "Restart BackgroundFu daemon"
task :restart_background_fu do
  run "cd #{current_path} && RAILS_ENV=#{stage} ./script/daemons stop"
  run "cd #{current_path} && RAILS_ENV=#{stage} ./script/daemons start"
end


