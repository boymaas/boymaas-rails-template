# Setup server packages needed by applpications

NeededPackages = %w{
  git-core
  curl

  nginx

  libpq-dev

  build-essential
  bison
  openssl
  libreadline5
  libreadline-dev
  git-core

  libxslt1-dev

  zlib1g
  zlib1g-dev

  libssl-dev

  libsqlite3-0
  libsqlite3-dev
  sqlite3

  libmysqlclient-dev

  libxml2-dev

  imagemagick

}

#after 'deploy:setup', 'deploy:install_packages'

namespace :deploy do
  task :install_packages, :role => :app do
    sudo "apt-get install -y -q #{NeededPackages * ' '}"
  end
end
