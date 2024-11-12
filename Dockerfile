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

# Configura el log de Apache para ser más detallado
RUN echo "LogLevel debug" >> /etc/apache2/apache2.conf

# Crea los directorios necesarios
RUN mkdir -p /var/www/html/public

# Copia la configuración de Apache
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Copia los archivos de la aplicación
COPY . /var/www/html/

# Configura permisos de forma más permisiva para debugging
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html \
    && chmod -R 777 /var/log/apache2

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Crea un script de inicio que incluye verificación
RUN echo '#!/bin/bash\n\
echo "Starting Apache..."\n\
echo "Current directory: $(pwd)"\n\
echo "Directory contents:"\n\
ls -la\n\
echo "Apache configuration:"\n\
apache2ctl -S\n\
echo "Starting Apache in foreground..."\n\
apache2-foreground' > /usr/local/bin/start.sh \
&& chmod +x /usr/local/bin/start.sh

# Puerto por defecto para Railway
ENV PORT=80

# Configura Apache para usar el puerto correcto
RUN echo '#!/bin/bash\n\
sed -i "s/Listen 80/Listen ${PORT:-80}/g" /etc/apache2/ports.conf\n\
sed -i "s/:80/:${PORT:-80}/g" /etc/apache2/sites-available/*.conf\n\
/usr/local/bin/start.sh' > /usr/local/bin/docker-entrypoint.sh \
&& chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE ${PORT}

CMD ["/usr/local/bin/docker-entrypoint.sh"]