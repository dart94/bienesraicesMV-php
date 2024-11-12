# Usa una imagen base de PHP con Apache
FROM php:8.2-apache

# Instala dependencias necesarias, por ejemplo mysqli para MySQL
RUN docker-php-ext-install mysqli

# Copia todos los archivos al directorio de trabajo de Apache
COPY . /var/www

# Configura Apache para usar la carpeta correcta
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Habilita mod_rewrite de Apache para el manejo de rutas
RUN a2enmod rewrite

# Establece el directorio de trabajo
WORKDIR /var/www/public

# Expone el puerto 80
EXPOSE 80

# Define el comando de inicio de Apache
CMD ["apache2-foreground"]
