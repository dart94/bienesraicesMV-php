#!/bin/bash

# Esperar a que la base de datos esté lista
echo "Esperando que la base de datos MySQL esté disponible..."
MAX_RETRIES=10
RETRIES=0
until mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" &> /dev/null || [ $RETRIES -eq $MAX_RETRIES ]
do
    echo "No se puede conectar a MySQL en $MYSQL_HOST. Intento $((RETRIES+1)) de $MAX_RETRIES"
    sleep 3
    RETRIES=$((RETRIES+1))
done

echo "¡Base de datos disponible o se agotaron los intentos! Continuando..."

# Configurar el puerto de Apache
export APACHE_PORT=${PORT:-80}

# Reemplazar el puerto en la configuración de Apache
sed -i "s/Listen 80/Listen ${APACHE_PORT}/g" /etc/apache2/ports.conf
sed -i "s/:80/:${APACHE_PORT}/g" /etc/apache2/sites-available/*.conf

# Crear archivo health check
echo "<?php
header(\"Content-Type: application/json\");
echo json_encode([\"status\" => \"healthy\"]);
?>" > /var/www/html/public/health.php

# Establecer permisos
chown -R www-data:www-data /var/www/html

# Iniciar Apache en primer plano
echo "Iniciando Apache..."
exec apache2-foreground
