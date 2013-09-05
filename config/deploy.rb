require "rvm/capistrano"
require "bundler/capistrano"

set :stages, %w(vagrant production)
set :rails_env, defer { stage }
# set :default_stage, "vagrant"
require 'capistrano/ext/multistage'

set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { stage }
set :whenever_output, defer { "#{shared_path}/log/cron.log" }
set :whenever_update_flags, defer { "--update-crontab #{whenever_identifier} --set environment=#{whenever_environment}\\&output=#{whenever_output}" } # notice the escaping \& passed to the shell
require "whenever/capistrano"

set :postgresql_user, ENV['DB_USER']
set :postgresql_password, ENV['DB_PASSWORD']

load 'config/recipes/foreman'
load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/rails"
load "config/recipes/postgresql"

set :application, "rails_deployment_example"
set :use_sudo, false
set :repository,  "."
set :deploy_to, defer { "/home/#{user}/apps/#{application}" }
set :deploy_via, :copy

set :rvm_type, :system

default_run_options[:pty] = true

after "deploy:restart", "deploy:cleanup"