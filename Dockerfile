# Use una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias (incluyendo mysqli para MySQL)
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    netcat \
    && docker-php-ext-install mysqli zip pdo pdo_mysql \
    && a2enmod rewrite

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos del proyecto
COPY . .

# Instalar dependencias de Composer si existe composer.json
RUN if [ -f "composer.json" ]; then composer install --no-dev --optimize-autoloader; fi

# Copia la configuración de Apache
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Habilita el módulo rewrite
RUN a2enmod rewrite

# Establece el ServerName para evitar advertencias
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Crear directorio storage y ajustar permisos
RUN mkdir -p /var/www/html/storage \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/storage

# Expone el puerto 80
EXPOSE 80

# Define el comando de arranque
CMD ["apache2-foreground"]