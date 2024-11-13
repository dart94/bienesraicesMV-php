#!/bin/bash
echo "Esperando que la base de datos MySQL esté disponible..."
MAX_RETRIES=10
RETRIES=0
until mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" &> /dev/null || [ $RETRIES -eq $MAX_RETRIES ]
do
  echo "No se puede conectar a MySQL en $MYSQL_HOST. Intento $((RETRIES+1)) de $MAX_RETRIES"
  sleep 3
  RETRIES=$((RETRIES+1))
done
echo "Iniciando Apache..."
exec apache2-foreground
