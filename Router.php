<?php

namespace MVC;

class Router {

    public $rutasGet = [];
    public $rutasPost = [];

    public function get($url, $fn){
        $this->rutasGet[$url] = $fn;
    }

    public function post($url, $fn){
        $this->rutasPost[$url] = $fn;
    }

    public function comprobarRutas(){

        session_start();
        $auth = $_SESSION['login'] ?? null ;


        //Areglo de rutas protegidas..
        $rutas_protegidas = ['/admin', '/propiedades/crear','/propiedades/actualizar','/propiedades/eliminar','/vendedores/crear','/vendedores/actualizar','/vendedores/eliminar'];

        $urlActual = strtok($_SERVER['REQUEST_URI'], '?') ?? '/';
        $metodo = $_SERVER['REQUEST_METHOD'];


        if($metodo == 'GET'){
            $fn = $this->rutasGet[$urlActual] ?? null;
        }else{
            $fn = $this->rutasPost[$urlActual] ?? null;
        }

        //Proteger las rutas
        if(in_array($urlActual, $rutas_protegidas)&& !$auth ){
            header('Location: /');
            
        }

        if($fn){
            call_user_func($fn,$this);

        }else{
            echo "Por el momento no se puede acceder a la ruta gracias $urlActual";
        }
    }

    //Muestra una vista
    public function render($view, $datos = []){

        foreach($datos as $key => $value){
            $$key = $value;
        }

        ob_start();
        
        include_once __DIR__ . "/views/$view.php";
        $contenido = ob_get_clean();
        include_once __DIR__ . "/views/layout.php";

    }
}


