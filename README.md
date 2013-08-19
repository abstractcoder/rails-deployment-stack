## Install Instructions

Install Virtual Box

then run the following commands:

git clone https://github.com/abstracoder/rails-deployment-example.git
cd rails-deployment-example
bundle
bundle exec berks install
bundle exec vagrant up
bundle exec knife solo bootstrap vagrant@localhost -p 2222 -i ~/.vagrant.d/insecure_private_key node.json 
bundle exec cap vagrant deploy:setup deploy:cold

## Production

Uncomment sensitive files in .gitignore once you start adding in your sensitive info.

## Development

## Mail

## Scheduled Tasks

## Background Tasks

## Technologies

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
* Sidekiq

* Ruby 2.0
* Rails 4.0

Create PostgreSQL user that is the same as app name
Run rake db:create

h3. Get App Running In Vagrant
In the root of the rails project

Special Thanks to Ryan Bates