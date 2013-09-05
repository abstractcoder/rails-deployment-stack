# encoding: utf-8

##
# Backup Generated: main_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t main_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:main_backup, 'Description for main_backup') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = "my_database_name"
    db.username           = "my_username"
    db.password           = "my_password"
    db.host               = "localhost"
    db.port               = 5432
    db.socket             = "/tmp/pg.sock"
    db.skip_tables        = ["skip", "these", "tables"]
    db.only_tables        = ["only", "these", "tables"]
    db.additional_options = ["-xc", "-E=utf8"]
  end

  ##
  # Redis [Database]
  #
  database Redis do |db|
    ##
    # From `dbfilename` in your `redis.conf` under SNAPSHOTTING.
    # Do not include the '.rdb' extension. Defaults to 'dump'
    db.name               = 'dump'
    ##
    # From `dir` in your `redis.conf` under SNAPSHOTTING.
    db.path               = '/var/lib/redis'
    db.password           = 'my_password'
    db.host               = 'localhost'
    db.port               = 6379
    db.socket             = '/tmp/redis.sock'
    db.additional_options = []
    db.invoke_save        = true
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = "~/backups/"
    local.keep       = 5
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

end
