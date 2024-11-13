# Use una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias (incluyendo mysqli para MySQL)
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install mysqli zip pdo pdo_mysql \
    && a2enmod rewrite

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copia todo el proyecto a la imagen
COPY . /var/www

# Instalar dependencias de Composer
WORKDIR /var/www
RUN composer install

# Configura Apache para usar la carpeta public como el DocumentRoot
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Habilita la reescritura de URL
RUN a2enmod rewrite

# Establece el ServerName para evitar advertencias
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Ajustar permisos de la carpeta del proyecto
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# Expone el puerto 80
EXPOSE 80

# Define el comando de arranque
CMD ["apache2-foreground"]
