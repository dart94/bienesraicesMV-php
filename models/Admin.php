<?php

namespace Model;

class admin extends ActiveRecord {

    // Base de datos
    protected static $tabla = 'usuarios';
    protected static $columnasDB = ['id', 'email', 'password'];

    public $id;
    public $email;
    public $password;
    
    public function __construct( $args = [] )
    {
        $this->id = $args['id'] ?? null;
        $this->email = $args['email'] ?? '';
        $this->password = $args['password'] ?? '';
    }

    public function validar(){
        if (!$this->email){
            self::$errores[] = 'El campo email es requerido';
        }
        if (!$this->password){
            self::$errores[] = 'El campo password es requerido';
        }
        return self::$errores;
    }

    public function existeUSuario(){
        // Verificar si el usuario existe
        $query = "SELECT * FROM " . self::$tabla . " WHERE email = '" . $this->email . "' LIMIT 1";

        $resultado = self::$db->query($query);
       

        if (!$resultado->num_rows) {
            self::$errores[] = 'El usuario no existe';
            return;
        }
        return $resultado;
    }

    public function comprobarPassword($resultado){
        $usuario = $resultado->fetch_object();
        $autenticado =password_verify($this->password, $usuario->password);
        if(!$autenticado){
            self::$errores[] = 'La contraseña es incorrecta';
        }

        return $autenticado;
    }

    public function autenticar(){
        session_start();

        //llenar el arreglo de sesion
        $_SESSION['usuario'] = $this->email;
        $_SESSION['login'] = true;
        header('Location: /admin');
    }
}
