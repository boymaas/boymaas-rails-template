# Set up capistrano

require "colored"
puts "Setting up Capistrano ... ".magenta

capistrano_template_dir = ( Pathname.new(File.dirname(__FILE__)) + 'capistrano' ).realpath

inside "config" do
  run "cp -r #{capistrano_template_dir}/* ."
  run "mv Capfile .."
end

#capify!

# Update deploy.rb !!
