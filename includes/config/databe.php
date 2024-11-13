<?php

function conectarDB(): mysqli
{
    // Debug: Imprime las variables de entorno para comprobar que se cargan correctamente
    var_dump(getenv('DB_HOST'));
    var_dump(getenv('DB_USER'));
    var_dump(getenv('DB_PASS'));
    var_dump(getenv('DB_NAME'));

    $db = new mysqli(
        getenv('DB_HOST'),
        getenv('DB_USER'),
        getenv('DB_PASS'),
        getenv('DB_NAME')
    );

    $db->set_charset('utf8');

    if ($db->connect_error) {
        echo "Error, no se pudo conectar a la base de datos: " . $db->connect_error;
        exit;
    }

    return $db;
}