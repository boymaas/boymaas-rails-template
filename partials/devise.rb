# Setup Devise
generate "devise:install"
model_name = ask("What model name should devise use? (default: user)?")
model_name = 'user' if model_name.blank?
generate "devise", model_name
generate 'devise:views'
