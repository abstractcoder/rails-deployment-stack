_cset :foreman_upstart_path, "/etc/init/"
_cset :foreman_cmd, "bundle exec foreman"
_cset :foreman_sudo, "rvmsudo"

namespace :foreman do  
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, roles: :app do
    run "if [[ -d #{foreman_upstart_path} ]]; then #{sudo} mkdir -p #{foreman_upstart_path}; fi"
    upload(File.expand_path("../../../deploy/env/#{stage}/.env", __FILE__), "/tmp/.env")
    upload(File.expand_path("../../../deploy/env/#{stage}/Procfile", __FILE__), "/tmp/Procfile")
    run "#{sudo} mv /tmp/.env #{current_path}/.env"
    run "#{sudo} mv /tmp/Procfile #{current_path}/Procfile"
    run "cd #{current_path} && #{foreman_sudo} #{foreman_cmd} export upstart #{foreman_upstart_path} --app #{application} --user #{user} --log #{shared_path}/log"
  end

  desc "Start the application services"
  task :start, roles: :app do
    sudo "#{sudo} service #{application} start"
  end

  desc "Stop the application services"
  task :stop, roles: :app do
    sudo "#{sudo} service #{application} stop"
  end

  desc "Restart the application services"
  task :restart, roles: :app do
    sudo "#{sudo} service #{application} start || #{sudo} service #{application} restart"
  end
end

after "deploy:update", "foreman:export"    # Export foreman scripts
after "deploy:update", "foreman:restart"   # Restart application scripts