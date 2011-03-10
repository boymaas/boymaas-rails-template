# Database configuration
 
set(:mysql_user, user) unless exists?(:mysql_user)
set(:mysql_database, user) unless exists?(:mysql_database)
set(:mysql_password, "") unless exists?(:mysql_password)
set(:mysql_test_database, "#{user}-test") unless exists?(:mysql_test_database)

before "deploy:setup", "db:configure"
after "deploy:update_code", "db:symlink"

namespace :db do
  desc "Create database yaml in shared path"
  task :configure do
    db_config = <<-EOF
base: &base
  adapter: mysql
  encoding: utf8
  username: #{mysql_user}
  password: #{mysql_password}

#{stage}:
  database: #{mysql_database}
  <<: *base

test:
  database: #{mysql_test_database}
  <<: *base
EOF

    run "mkdir -p #{shared_config_path}"
    put db_config, shared_configuration_location_for(:database)
  end

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_configuration_location_for(:database)} #{latest_release}/config/database.yml"
  end
end

