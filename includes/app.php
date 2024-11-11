<?php

use Model\ActiveRecord;
require __DIR__ . '/../vendor/autoload.php';

$doteenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../includes'); // Cambia el path si es necesario
$doteenv->safeLoad();

require 'funciones.php';
require 'config/databe.php';

// Conexión a la base
$db = conectarDB();
ActiveRecord::setdb($db);
