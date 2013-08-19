namespace :rails do
  desc "Remote console"
  task :console, :roles => :app do
    run_interactively "bundle exec rails console #{rails_env}"
  end

  desc "Remote dbconsole"
  task :dbconsole, :roles => :app do
    run_interactively "bundle exec rails dbconsole #{rails_env}"
  end
  
  desc "Run anything"
  task :run, roles: :app do
    exec "RAILS_ENV=#{rails_env} bundle exec foreman run #{ENV['TASK']}"
  end
  
  desc "Tail log"
  task :log, roles: :app do
    run_interactively "cd #{shared_path}/log; tail -f #{ENV['LOG'] || stage}.log"
  end
end

def run_interactively(command, server=nil)
  server ||= find_servers_for_task(current_task).first
  exec %Q(ssh #{user}@#{server.host} -p #{ssh_options[:port] || 22} -t 'sudo su - #{user} -c "cd #{current_path} && #{command}"')
end