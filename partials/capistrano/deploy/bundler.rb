# -BUNDLER INSTALL-----------------------------------------------------------------
# Using bundler to package and install
# gems on remote site.

# Make sure all gems are locally installed and packaged
# before deploying
#
# This should handle the installation of all the dependencies
require 'bundler/capistrano'
# install all gems .. so we can run tests, on the remote site
set :bundle_without, []
