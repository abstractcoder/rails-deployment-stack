# Rails Deployment Stack

A simple single server deployment stack that handles server provisioning and application deployment. Includes local testing with Vagrant as well as Production deployments. Use this as the basis for your own deployment stack.

## Prerequisites

#### Install Git
#### Install [Virtual Box](https://www.virtualbox.org)
#### Install Ruby 2.0
To quickly get up and running you can install Ruby 2.0 through RVM
```bash
\curl -L https://get.rvm.io | bash -s stable --ruby=2.0
```
If you already have RVM installed
```bash
rvm get stable
rvm install 2.0
```
#### Install Bundler
```bash
gem install bundler
```

## Install Commands

```bash
git clone https://github.com/abstractcoder/rails-deployment-stack.git
cd rails-deployment-stack
bundle install --gemfile Gemfile.tools
bundle
BUNDLE_GEMFILE=Gemfile.tools bundle exec berks install
BUNDLE_GEMFILE=Gemfile.tools bundle exec vagrant up
BUNDLE_GEMFILE=Gemfile.tools bundle exec knife solo prepare vagrant@localhost -p 2222 -i ~/.vagrant.d/insecure_private_key node.json
BUNDLE_GEMFILE=Gemfile.tools bundle exec knife solo cook vagrant@localhost -p 2222 -i ~/.vagrant.d/insecure_private_key node.json
cd deploy/env/vagrant && bundle exec foreman run cap vagrant deploy:setup deploy:cold
```

Type in password for PostgreSQL user. The vagrant database.yml has this set to 'secret'. This WILL CHANGE in future versions of the stack.

Visit https://192.168.33.10/

Setup Swap

```bash
sudo dd if=/dev/zero of=/swapfile bs=1024 count=512k
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo '/swapfile       none    swap    sw      0       0 ' >> /etc/fstab
sudo chown root:root /swapfile 
sudo chmod 0600 /swapfile
```

Todo: 

Schedule automatic reboots

## Production

Uncomment sensitive files in .gitignore once you start adding in your info.

Coming Soon...

## Development

Coming Soon...

## Mail

Coming Soon...

## Scheduled Tasks

Coming Soon...

## Background Tasks

Coming Soon...

## Technologies

```
* Chef
* Knife Solo
* Capistano
* Berkshelf

* Vagrant
* Virtualbox
* Foreman
* Upstart
* RVM

* Unicorn
* Mailcatcher
* Whenever
* Redis
* Sidekiq
* Backup

* Ruby 2.0
* Rails 4.0
```

## Changes from stock Rails
[View Changes](https://github.com/abstractcoder/rails-deployment-stack/compare/fe308ca55ffd653d2b045473d4c9cca8e0af8bc0...HEAD)

```
A       .env
M       .gitignore
A       Berksfile
A       Berksfile.lock
A       Capfile
M       Gemfile
M       Gemfile.lock
A       Procfile
M       README.md
A       .env
M       .gitignore
A       Berksfile
A       Berksfile.lock
A       Capfile
M       Gemfile
M       Gemfile.lock
A       Procfile
M       README.md
A       Vagrantfile
A       app/assets/javascripts/welcome.js.coffee
A       app/assets/stylesheets/welcome.css.scss
A       app/controllers/welcome_controller.rb
A       app/helpers/welcome_helper.rb
A       app/views/welcome/index.html.erb
A       config/deploy.rb
A       config/deploy/production.rb
A       config/deploy/vagrant.rb
M       config/environments/production.rb
A       config/environments/vagrant.rb
A       config/recipes/base.rb
A       config/recipes/foreman.rb
A       config/recipes/nginx.rb
A       config/recipes/postgresql.rb
A       config/recipes/rails.rb
A       config/recipes/templates/nginx_unicorn.conf.erb
A       config/recipes/templates/openssl.conf.erb
A       config/recipes/templates/unicorn.rb.erb
A       config/recipes/unicorn.rb
M       config/routes.rb
A       config/schedule.rb
A       deploy/env/production/.env
A       deploy/env/vagrant/.env
A       deploy/env/vagrant/Procfile
A       deploy/env/vagrant/database.yml
A       node.json
A       test/controllers/welcome_controller_test.rb
A       test/helpers/welcome_helper_test.rb
```

## Thanks

Special Thanks to Ryan Bates

More Coming Soon...

## Todos
- Backup gem
- Make sure everything works
- Remove password requirement from PostgreSQL setup
- Make postgres role and database creation idempotent
- Make rvm install idempotent
