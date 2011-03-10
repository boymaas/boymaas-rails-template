# Set up rspec

############################################################
# Generate RSpec and Cucumber
#

# Setup RSpec and Cucumber
generate "rspec:install"
generate "cucumber:install", "--rspec --capybara"
generate "machinist:install"

# Setup Machinist and Faker
run 'mkdir -p spec/support'
file 'spec/support/blueprints.rb', <<-END
require 'machinist/active_record'
require 'faker'
require 'sham'

Sham.email { Faker::Internet.email }
Sham.hostname { Faker::Internet.domain_name }
Sham.name { Faker::Name.name }
Sham.text { Faker::Lorem.sentence }

END

# doing { something }.should change(Something, :count).by(1)
file 'spec/support/custom.rb', <<-END
alias :doing :lambda
END

git :add => "."
git :commit => "-a -m 'Installed RSpec, Cucumber and Machinist'"
