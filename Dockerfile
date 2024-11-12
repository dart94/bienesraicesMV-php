FROM php:8.2-apache

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install mysqli zip pdo pdo_mysql \
    && a2enmod rewrite

# Configurar Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Crear directorio para los logs
RUN mkdir -p /var/log/apache2 \
    && touch /var/log/apache2/error.log \
    && touch /var/log/apache2/access.log \
    && chown -R www-data:www-data /var/log/apache2

# Copiar archivos de la aplicación
COPY . /var/www/html/

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Instalar Composer e instalar dependencias
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Script de inicio
RUN echo '#!/bin/bash\n\
# Obtener el puerto de la variable de entorno o usar 80 por defecto\n\
export PORT=${PORT:-80}\n\
\n\
# Configurar Apache para usar el puerto correcto\n\
sed -i "s/Listen 80/Listen ${PORT}/g" /etc/apache2/ports.conf\n\
sed -i "s/:80/:${PORT}/g" /etc/apache2/sites-available/*.conf\n\
\n\
# Iniciar Apache\n\
apache2-foreground\n'\
> /usr/local/bin/start-apache.sh \
&& chmod +x /usr/local/bin/start-apache.sh

WORKDIR /var/www/html

CMD ["/usr/local/bin/start-apache.sh"]