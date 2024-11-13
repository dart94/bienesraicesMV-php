#!/bin/bash
set -e

# Crear o actualizar el archivo .env
cat > /var/www/html/includes/.env << EOF
DB_HOST=${MYSQLHOST:-db}
DB_USER=${MYSQLUSER:-root}
DB_PASS=${MYSQLPASSWORD:-1234}
DB_NAME=${MYSQLDATABASE:-bienesraices_crud}
EMAIL_HOST=${EMAIL_HOST:-sandbox.smtp.mailtrap.io}
EMAIL_PORT=${EMAIL_PORT:-2525}
EMAIL_USER=${EMAIL_USER}
EMAIL_PASS=${EMAIL_PASS}
EOF

# Ejecutar el comando proporcionado
exec "$@"