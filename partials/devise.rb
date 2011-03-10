# Setup Devise
if ask("Setup Devise? (N/y)").upcase == 'Y'
  generate "devise:install"
  model_name = ask("What model name should devise use? (default: user)?")
  model_name = 'user' if model_name.blank?
  generate "devise", model_name
  generate 'devise:views'

  git :add => "."
  git :commit => "-a -m 'Setup devise'"
else
  say "=> Skipping Devise setup"
end
