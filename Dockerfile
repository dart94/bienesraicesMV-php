# Use una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias (incluyendo mysqli para MySQL)
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copia todo el proyecto a la imagen
COPY . /var/www

# Configura Apache para usar la carpeta public como el DocumentRoot
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Habilita la reescritura de URL
RUN a2enmod rewrite

# Establece el ServerName para evitar advertencias
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Establece el directorio de trabajo
WORKDIR /var/www/public

# Expone el puerto 80
EXPOSE 80

# Define el comando de arranque
CMD ["apache2-foreground"]
