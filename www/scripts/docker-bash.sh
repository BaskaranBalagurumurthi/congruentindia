#!/bin/bash

docker exec -it -e LINES=$(tput lines) -e COLUMNS=$(tput cols) interactives_drupal bash