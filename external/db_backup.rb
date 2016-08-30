# encoding: utf-8

##
# Backup Generated: db_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t db_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:db_backup, 'Production server database backup') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  # load login info
  PROJECT_ROOT = '/home/fabiow/Desktop/Florian/'
  db_config           = YAML.load_file(PROJECT_ROOT + 'config/database.yml')
  app_config          = YAML.load_file(PROJECT_ROOT + 'config/application.yml')


  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = 'db/production'
    db.username           = db_config['username']
    db.password           = db_config['password']
    db.host               = 'localhost'
  end

  ##
  # SCP (Secure Copy) [Storage]
  #
  store_with SCP do |server|
    server.username   = app_config['backup']['storage']['username']
    server.password   = app_config['backup']['storage']['password']
    server.ip         = app_config['backup']['storage']['ip']
    server.port       = app_config['backup']['storage']['port']
    server.path       = PROJECT_ROOT + 'backups'
    server.keep       = 5
  end

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  #notify_by Mail do |mail|
  #  mail.on_success           = true
  #  mail.on_warning           = true
  #  mail.on_failure           = true

  #  mail.from                 = app_config['backup']['notifier']['username']
  #  mail.to                   = app_config['backup']['notifier']['username']
  #  mail.address              = app_config['backup']['notifier']['address']
  #  mail.port                 = app_config['backup']['notifier']['port']
  #  mail.domain               = app_config['backup']['notifier']['domain']
  #  mail.user_name            = app_config['backup']['notifier']['username']
  #  mail.password             = app_config['backup']['notifier']['password']
  #  mail.authentication       = "plain"
  #  mail.encryption           = :starttls
  #end

end
