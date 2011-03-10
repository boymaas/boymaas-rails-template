# Setup Simple Form
generate "simple_form:install"
plugin 'country_select', :git => 'git://github.com/rails/country_select.git'

git :add => "."
git :commit => "-a -m 'Installed Simple Form'"
