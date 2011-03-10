############################################################
# Database and create
#

# Remove default database file
run 'rm config/database.yml'

# Use the only real database :)
file "config/database.yml", <<-END
development: &development 
  encoding: utf8
  adapter: mysql
  username: root
  #port: 5432
  #host: localhost
  database: #{app_name}_development
  password: hermit

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test: &test
  <<: *development
  database: #{app_name}_test

cucumber:
  <<: *test
END

environment " config.time_zone = 'UTC'"

# Make a copy to check in
run 'cp config/database.yml config/database.example.yml'

# Create the DB
rake("db:create")
