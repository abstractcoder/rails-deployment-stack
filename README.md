# Rails Deployment Stack

A simple single server deployment stack that handles server provisioning and application deployment. Includes local testing with Vagrant as well as Production deployments. Use this as the basis for your own deployment stack.

## Prerequisite

Install Virtual Box

## Install Commands

git clone https://github.com/abstracoder/rails-deployment-example.git
cd rails-deployment-example
bundle
bundle exec berks install
bundle exec vagrant up
bundle exec knife solo bootstrap vagrant@localhost -p 2222 -i ~/.vagrant.d/insecure_private_key node.json 
bundle exec cap vagrant deploy:setup deploy:cold

## Production

Uncomment sensitive files in .gitignore once you start adding in your sensitive info.

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

* Ruby 2.0
* Rails 4.0

## Thanks

Special Thanks to Ryan Bates

More Coming Soon...