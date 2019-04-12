#/bin/sh

ROOT='/var/www/html'

# Creates the database if not exists.
build_database () {
  if [ ! $(mysql --host=mysql --user=root --password=cit-interactives -e"SHOW DATABASES LIKE 'citinteractives';") ]; then
    # Create a database to use.
    mysql --host=mysql --user=root --password=cit-interactives -e"CREATE DATABASE citinteractives;"
  fi
}

# bootstraps drupal core, dependencies and database
build_database

# execute docker cmd replacement
exec "apache2-foreground"
