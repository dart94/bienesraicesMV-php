# Usa una imagen base de PHP con Apache
FROM php:8.2-apache

# Instala dependencias necesarias, como mysqli
RUN docker-php-ext-install mysqli

# Copia todos los archivos al directorio de trabajo de Apache
COPY . /var/www

# Configura Apache para usar la carpeta correcta
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Habilita mod_rewrite de Apache para el manejo de rutas
RUN a2enmod rewrite

# Configura el ServerName para evitar el mensaje de advertencia
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Establece el directorio de trabajo
WORKDIR /var/www/public

# Expone el puerto 80 para HTTP
EXPOSE 80

# Define el comando de inicio de Apache
CMD ["apache2-foreground"]
