<?php

require_once __DIR__ . '/../vendor/autoload.php';

// Cargar variables del .env
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../includes');
$dotenv->load();

try {
    $db_host = getenv('DB_HOST') ?: 'localhost';
    $db_user = getenv('DB_USER') ?: 'root';
    $db_pass = getenv('DB_PASS') ?: '';
    $db_name = getenv('DB_NAME') ?: '';

    $mysqli = new mysqli($db_host, $db_user, $db_pass, $db_name);

    if ($mysqli->connect_error) {
        throw new Exception("Error de conexión: " . $mysqli->connect_error);
    }
} catch (Exception $e) {
    die($e->getMessage());
}
