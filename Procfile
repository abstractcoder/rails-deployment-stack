web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
redis: redis-server /usr/local/etc/redis.conf
worker: bundle exec sidekiq
mail: mailcatcher --foreground