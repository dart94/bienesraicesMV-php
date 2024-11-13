#!/bin/bash
set -e

# Esperar a que la base de datos esté disponible
wait_for_db() {
    host="${DB_HOST:-db}"
    until nc -z -v -w30 "$host" 3306; do
        echo "Waiting for database connection..."
        sleep 5
    done
}

# Si estamos en Render (verificando la presencia de RENDER variable)
if [ -n "$RENDER" ]; then
    wait_for_db
    
    # Crear o actualizar el archivo .env
    cat > /var/www/html/includes/.env << EOF
DB_HOST=${DB_HOST}
DB_USER=${DB_USER}
DB_PASS=${DB_PASS}
DB_NAME=${DB_NAME}
EMAIL_HOST=${EMAIL_HOST}
EMAIL_PORT=${EMAIL_PORT}
EMAIL_USER=${EMAIL_USER}
EMAIL_PASS=${EMAIL_PASS}
EOF
fi

# Ejecutar el comando proporcionado (normalmente apache2-foreground)
exec "$@"