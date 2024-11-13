<?php

function conectarDB() {
    $db = new mysqli(
        $_ENV['DB_HOST'] ?? 'db',
        $_ENV['DB_USER'] ?? 'root',
        $_ENV['DB_PASS'] ?? '1234',
        $_ENV['DB_NAME'] ?? 'bienesraices_crud'
    );

    if (!$db) {
        echo "Error: No se pudo conectar a MySQL.";
        echo "errno de depuración: " . mysqli_connect_errno();
        echo "error de depuración: " . mysqli_connect_error();
        exit;
    }

    return $db;
}