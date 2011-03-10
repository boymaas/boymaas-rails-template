# Our Global Web Server - NGINX

set :nginx_port, 8000      unless exists?(:nginx_port)

after "deploy:setup",   "nginx:build_configuration"

namespace :nginx do 
  desc "builds the nginx configuration to be linked in."
  task :build_configuration, :roles => :web do

    upstream_identifier = "#{application}_#{stage}"

    nginx_server_config = <<-nginx
        upstream  #{upstream_identifier} {
          server unix:#{shared_socket_for(unicorn_socket_name)} fail_timeout=0;
        }

        server {
          listen #{nginx_port} default deferred; # for linux
          server_name #{domain};

          client_max_body_size 32M;

          root #{current_path};

          location / {
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_redirect off;

            if (-f $request_filename/index.html) {
              rewrite (.*) $1/index.html break;
            }
            if (-f $request_filename.html) {
              rewrite (.*) $1.html break;
            }
            if (!-f $request_filename) {
              proxy_pass http://#{upstream_identifier};
              break;
            }
          }

          error_page 500 502 503 504 /50x.html;
          location = /50x.html {
            root html;
          }
        } 
    nginx

    put nginx_server_config, shared_configuration_location_for(:nginx, :config)

    # link this configuration in the sites-enabled location of nginx
    nginx_config_target = "/etc/nginx/sites-enabled/#{application}-#{stage}"
    run "rm #{nginx_config_target};true"
    run "ln -s #{shared_configuration_location_for(:nginx, :config)} #{nginx_config_target}"
  end

  %w(start stop restart reload).each do |action|
    desc "#{action} the Nginx processes on the web server."
    task action.to_sym , :roles => :web do
      sudo "/etc/init.d/nginx #{action}"
    end
  end

end
