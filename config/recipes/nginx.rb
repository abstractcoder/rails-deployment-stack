namespace :nginx do
  desc "Setup nginx from current application"
  task :setup, roles: :web do
    template "nginx_unicorn.conf.erb", "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
    
    if File.exists? "../../../deploy/env/#{stage}/server.crt" and File.exists? "../../../deploy/env/#{stage}/server.key"
      upload(File.expand_path("../../../deploy/env/#{stage}/server.crt", __FILE__), "/tmp/server.crt")
      upload(File.expand_path("../../../deploy/env/#{stage}/server.key", __FILE__), "/tmp/server.key")
    else

      # Generate new self signed certs
      run "cd /tmp && openssl genrsa -des3 -passout pass:x -out server.pass.key 2048"
      run "cd /tmp && openssl rsa -passin pass:x -in server.pass.key -out server.key"
      template("openssl.conf.erb", "/tmp/openssl.conf")
      run "cd /tmp && openssl req -config openssl.conf -new -key server.key -out server.csr"
      run "cd /tmp && openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt"
      run "cd /tmp && rm server.csr server.pass.key openssl.conf"
    end

    
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