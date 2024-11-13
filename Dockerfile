FROM php:8.2-apache

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install mysqli zip pdo pdo_mysql \
    && a2enmod rewrite

# Configurar el usuario Apache para que tenga acceso a los logs
RUN usermod -u 1000 www-data \
    && groupmod -g 1000 www-data

# Configurar logs y permisos
RUN mkdir -p /var/log/apache2 \
    && touch /var/log/apache2/error.log \
    && touch /var/log/apache2/access.log \
    && chown -R www-data:www-data /var/log/apache2 \
    && chmod -R 777 /var/log/apache2

# Copiar archivos de la aplicación
COPY --chown=www-data:www-data . /var/www/html/

# Configurar Apache
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Script de health check
RUN echo '#!/bin/bash\n\
if curl -f http://localhost:${PORT:-80}/health.php; then\n\
    exit 0\n\
else\n\
    exit 1\n\
fi' > /usr/local/bin/docker-healthcheck \
&& chmod +x /usr/local/bin/docker-healthcheck

# Crear script de inicio que incluye la espera por la base de datos
RUN echo '#!/bin/bash\n\
\n\
# Esperar a que la base de datos esté lista\n\
until mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" &> /dev/null\n\
do\n\
    echo "Waiting for MySQL to be ready..."\n\
    sleep 3\n\
done\n\
\n\
# Configurar el puerto\n\
export APACHE_PORT=${PORT:-80}\n\
\n\
# Reemplazar el puerto en la configuración de Apache\n\
sed -i "s/Listen 80/Listen ${APACHE_PORT}/g" /etc/apache2/ports.conf\n\
sed -i "s/:80/:${APACHE_PORT}/g" /etc/apache2/sites-available/*.conf\n\
\n\
# Crear archivo health check\n\
echo "<?php\n\
header(\"Content-Type: application/json\");\n\
echo json_encode([\"status\" => \"healthy\"]);\n\
?>" > /var/www/html/public/health.php\n\
\n\
# Establecer permisos\n\
chown -R www-data:www-data /var/www/html\n\
\n\
# Iniciar Apache en primer plano\n\
exec apache2-foreground\n' > /usr/local/bin/start-apache.sh \
&& chmod +x /usr/local/bin/start-apache.sh

# Configurar PHP
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/error-reporting.ini \
    && echo "display_errors = On" >> /usr/local/etc/php/conf.d/error-reporting.ini \
    && echo "log_errors = On" >> /usr/local/etc/php/conf.d/error-reporting.ini

# Optimización de Apache
RUN echo "MaxRequestWorkers 5" >> /etc/apache2/apache2.conf
RUN echo "StartServers 1" >> /etc/apache2/apache2.conf
RUN echo "MinSpareServers 1" >> /etc/apache2/apache2.conf
RUN echo "MaxSpareServers 2" >> /etc/apache2/apache2.conf

# Configuración de PHP
RUN echo "memory_limit = 64M" >> /usr/local/etc/php/php.ini

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
    CMD /usr/local/bin/docker-healthcheck

# Exponer puerto
EXPOSE 80

# Comando de inicio combinado
CMD ["/usr/local/bin/start-apache.sh"]
