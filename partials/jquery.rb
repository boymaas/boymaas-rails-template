############################################################
# Install JQuery
#

# Downloading latest jQuery.min
get "http://code.jquery.com/jquery-latest.min.js", "public/javascripts/jquery.js"

# Downloading latest jQuery drivers
get "https://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

# Create a base application.js
file "public/javascripts/application.js", <<-END
jQuery(function ($) {
/**
* App code in here
*/
};
END

# Override javascript_link_tag :defaults
environment " config.action_view.javascript_expansions[:defaults] = ['jquery', 'rails']"

git :add => "."
git :commit => "-a -m 'Installed JQuery'"

