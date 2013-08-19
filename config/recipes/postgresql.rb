_cset(:postgresql_host, "localhost")
_cset(:postgresql_user) { application }
_cset(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
_cset(:postgresql_database) { "#{application}_#{stage}" }

namespace :postgresql do
  desc "Create a database for this application."
  task :create_database, roles: :db, only: {primary: true} do
    run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
  end
  after "deploy:setup", "postgresql:create_database"

  desc "Upload the database.yml for the current environment"
  task :upload_config, roles: :app do
    upload(File.expand_path("../../../deploy/env/#{stage}/database.yml", __FILE__), "/tmp/database.yml")
    run "#{sudo} mv /tmp/database.yml #{current_path}/config/database.yml"
  end
  after "deploy:finalize_update", "postgresql:upload_config"
end