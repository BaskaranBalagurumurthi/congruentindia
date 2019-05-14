#!/bin/bash 
 
#docker container restart interactives_drupal interactives_mysql
 
cd /home/cituser/Desktop/congruentindia/www/ 
 
composer install
 
docker exec -i interactives_drupal /bin/bash -c "drush cim -y"

docker exec -i interactives_drupal /bin/bash -c "drush updb -y"
 
docker exec -i interactives_drupal /bin/bash -c "drush cr"
