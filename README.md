# Rails Deployment Stack

A simple single server deployment stack that handles server provisioning and application deployment. Includes local testing with Vagrant as well as Production deployments. Use this as the basis for your own deployment stack.

## Prerequisite

Install [Virtual Box](https://www.virtualbox.org)

## Install Commands

```bash
git clone https://github.com/abstracoder/rails-deployment-stack.git
cd rails-deployment-example
bundle
bundle exec berks install
bundle exec vagrant up
bundle exec knife solo bootstrap vagrant@localhost -p 2222 -i ~/.vagrant.d/insecure_private_key node.json 
bundle exec cap vagrant deploy:setup deploy:cold
```

Type in password for PostgreSQL user. The vagrant database.yml has this set to 'secret'. This WILL CHANGE in future versions of the stack.

Visit https://192.168.33.10/

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

* Ruby 2.0
* Rails 4.0
```

## Thanks

Special Thanks to Ryan Bates

More Coming Soon...

## Todos
- [ ] Make sure everything works
- [ ] Automatically generate self signed certificate
- [ ] Upload production certificates
