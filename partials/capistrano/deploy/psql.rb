# Database configuration
 
set(:psql_user, user) unless exists?(:psql_user)
set(:psql_database, user) unless exists?(:psql_database)
set(:psql_password, "") unless exists?(:psql_password)
set(:psql_test_database, "#{user}-test") unless exists?(:psql_test_database)

before "deploy:setup", "db:configure"
after "deploy:update_code", "db:symlink"

namespace :db do
  desc "Create database yaml in shared path"
  task :configure do
    db_config = <<-EOF
base: &base
  adapter: postgresql
  encoding: utf8
  username: #{psql_user}
  password: #{psql_password}

#{stage}:
  database: #{psql_database}
  <<: *base

test:
  database: #{psql_test_database}
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

