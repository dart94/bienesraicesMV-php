<?php

namespace Controllers;
use MVC\Router;
use Model\Admin;


class LoginController{
    public static function login(Router $router){
        
        $errores = [];

        if($_SERVER['REQUEST_METHOD'] === 'POST'){
            
            $auth = new Admin($_POST);
            $errores = $auth->validar();

            if(empty($errores)){
                // Verificar si el usuario existe
                $resultado = $auth->existeUSuario();

                if(!$resultado){
                    // Verisficar si el suauario existe  o no (Mensaje de error)
                    $errores = Admin::getErrores();
                } else{
                     // Verificar si la contraseña es correcta
                     $autenticado =$auth->comprobarPassword($resultado);
                     if($autenticado){
                        // Autenticar el usuario
                        $auth->autenticar();
                     } else {
                        //Pasword incorrecto
                        $errores = Admin::getErrores();
                     }
                }
            }
        }
        $router->render('auth/login',[
            'errores'=> $errores
        ]);
    }

    public static function logout(){
        session_start();
        $_SESSION = [];
        header('Location: /');
    }
}