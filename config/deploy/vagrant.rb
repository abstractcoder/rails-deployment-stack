set :user, "vagrant"
set :ssh_options, {port: 2222, keys: ['~/.vagrant.d/insecure_private_key']}
server "localhost", :web, :app, :db, primary: true