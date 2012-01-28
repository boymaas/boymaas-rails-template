# make sure rvm is installed on server
#
after 'deploy:setup', 'deploy:install_rvm'
namespace :deploy do
  desc "Installs rvm on the user account if not already exists"
  task :install_rvm, :role => :app do

  put <<-SHELL_SCRIPT, 'install_rvm', :mode => '750'
#!/bin/bash 
if ! [[ -d .rvm ]]; then
  bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
  echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"' >> .profile
  echo 'export RAILS_ENV="#{stage}"' >> .profile
  source "$HOME/.rvm/scripts/rvm"

  rvm install 1.8.7 
  rvm use 1.8.7 --default
fi
SHELL_SCRIPT
    run './install_rvm', :shell => false
    run 'rm install_rvm', :shell => false
  end
end
