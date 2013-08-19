namespace :nginx do
  desc "Setup nginx from current application"
  task :setup, roles: :web do
    template "nginx_unicorn.conf.erb", "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
    
    upload(File.expand_path("../../../deploy/env/#{stage}/server.crt", __FILE__), "/tmp/server.crt")
    upload(File.expand_path("../../../deploy/env/#{stage}/server.key", __FILE__), "/tmp/server.key")
    
    run "#{sudo} mv /tmp/server.crt /etc/nginx/server.crt"
    run "#{sudo} mv /tmp/server.key /etc/nginx/server.key"
    
    restart
  end
  after "deploy:setup", "nginx:setup"
  
  %w[start stop restart].each do |command|
    desc "#{command} nginx server"
    task command, roles: :web  do
      run "#{sudo} service nginx #{command}"
    end
  end
end