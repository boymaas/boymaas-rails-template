# Check prerequisites
[:colored, :rails, :bundler, :compass, :'html5-boilerplate', :haml].map(&:to_s).each do |prerequite|
  unless Gem.available?(prerequite)
    run "gem install #{prerequite}"
    Gem.refresh
    Gem.activate(prerequite)
  end
end

require "colored"
require "rails"
require "bundler"
require "haml"

# Set directory for partials
@partials = "#{File.dirname(__FILE__)}/partials"

puts "\n========================================================="
puts " RAILS 3 TEMPLATE".yellow.bold
puts "=========================================================\n"

apply "#{@partials}/gemfile.rb"
apply "#{@partials}/rvm.rb"           # Must be after gemfile since it runs bundler
apply "#{@partials}/git.rb"           
apply "#{@partials}/boilerplate.rb"
apply "#{@partials}/grid.rb"          # Must be after boilerplate since it modifies SASS files
apply "#{@partials}/stylesheets.rb"   # Must be after boilerplate since it modifies SASS files
apply "#{@partials}/jquery.rb"
apply "#{@partials}/layouts.rb"       # Must be after boilerplate since it modifies HAML files
apply "#{@partials}/helpers.rb"
apply "#{@partials}/appconfig.rb"
apply "#{@partials}/rspec.rb"
apply "#{@partials}/capistrano.rb"
apply "#{@partials}/application.rb"
apply "#{@partials}/friendly_id.rb"   # Must be after application.rb since it runs migrations
apply "#{@partials}/demo.rb"
apply "#{@partials}/cleanup.rb"

# extra's
apply "#{@partials}/database.rb"
apply "#{@partials}/devise.rb"
apply "#{@partials}/simple_form.rb"

puts "\n========================================================="
puts " INSTALLATION COMPLETE!".yellow.bold
puts "=========================================================\n\n\n"
