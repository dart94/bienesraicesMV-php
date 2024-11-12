# Usa una imagen base de PHP con Apache
FROM php:8.2-apache

# Instala dependencias del sistema y extensiones PHP necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install mysqli zip pdo pdo_mysql \
    && a2enmod rewrite

# Configura el ServerName
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copia la configuración de Apache primero
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Crea el directorio public si no existe
RUN mkdir -p /var/www/html/public

# Copia los archivos de la aplicación
COPY . /var/www/html/

# Configura permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Variable de entorno para el puerto de Railway
ENV PORT=80

# Script para ajustar el puerto de Apache dinámicamente
RUN echo '#!/bin/bash\n\
sed -i "s/Listen 80/Listen ${PORT:-80}/g" /etc/apache2/ports.conf\n\
sed -i "s/:80/:${PORT:-80}/g" /etc/apache2/sites-available/*.conf\n\
apache2-foreground' > /usr/local/bin/docker-entrypoint.sh \
&& chmod +x /usr/local/bin/docker-entrypoint.sh

# Expone el puerto que será asignado por Railway
EXPOSE ${PORT}

# Usa el script de entrada como comando
CMD ["/usr/local/bin/docker-entrypoint.sh"]