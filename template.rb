# Check prerequisites
[:colored, :rails].map(&:to_s).each do |prerequite|
  unless Gem.available?(prerequite)
    run "gem install #{prerequite}"
  end
end

require "colored"
require "rails"

# Set directory for partials
@partials = "#{File.dirname(__FILE__)}/partials"

puts "\n========================================================="
puts " RAILS 3 TEMPLATE".yellow.bold
puts "=========================================================\n"

def apply_and_commit partial, msg = nil
  apply "#{@partials}/#{partial}.rb"

  msg ||= "Applied phase #{partial} .."

  git :add => "."
  git :commit => "-am '#{msg}'"
end

apply "#{@partials}/git.rb"           
apply_and_commit :cleanup, 'Initial commit of clean rails installation'
apply_and_commit :gemfile
apply_and_commit :rvm           # Must be after gemfile since it runs bundler
apply_and_commit :boilerplate
apply_and_commit :jquery
apply_and_commit :helpers
apply_and_commit :appconfig
apply_and_commit :rspec
apply_and_commit :capistrano
apply_and_commit :application
apply_and_commit :friendly_id   # Must be after application.rb since it runs migrations
apply_and_commit :barista

# extra's
apply_and_commit :database
apply_and_commit :devise if ask("Setup Devise? (N/y)").upcase == 'Y'
apply_and_commit :simple_form

puts "\n========================================================="
puts " INSTALLATION COMPLETE!".yellow.bold
puts "=========================================================\n\n\n"
