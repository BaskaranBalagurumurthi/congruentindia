#!/bin/bash

docker exec -it interactives_drupal drush --strict=0 --root=/var/www/web --destination=/var/www/web/profiles/cit/config/sync --source=/var/www/web/profiles/cit/config/sync --uri=local-congruent.com/cit $@

