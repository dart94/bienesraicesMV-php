#!/bin/bash
until mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" &> /dev/null
do
  echo "Waiting for MySQL to be ready..."
  sleep 3
done

apache2-foreground
