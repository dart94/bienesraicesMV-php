<?php

namespace Controllers;

use MVC\Router;
use Model\Propiedad;
use PHPMailer\PHPMailer\PHPMailer;

class PaginasController {
    public static function index(Router $router){
        
        $propiedades = Propiedad::get(3);
        $inicio = true;

        $router->render('paginas/index',[
            'propiedades' => $propiedades,
            'inicio' => $inicio
        ]);
    }
    public static function nosotros(Router $router){
        $router->render('paginas/nosotros');
        
    }
    public static function propiedades(Router $router){
        $propiedades = Propiedad::all(  );
        
        $router->render('paginas/propiedades',[
            'propiedades' => $propiedades
        ]);
    }

    public static function propiedad(Router $router) {
        $id = validarORedireccionar('/propiedades');

        // Obtener los datos de la propiedad
        $propiedad = Propiedad::find($id);

        $router->render('paginas/propiedad', [
            'propiedad' => $propiedad
        ]);
    }

    public static function blog(Router $router){
        $router->render('paginas/blog');
    }
    public static function entrada(Router $router){
        $router->render('paginas/entrada');
        
    }
    public static function contacto(Router $router){

        $mensaje = null;

        if($_SERVER['REQUEST_METHOD'] == 'POST'){

            $respuestas = $_POST['contacto'];

            

            
            
            //Crear una instancia de PHPMailer
            $mail = new PHPMailer();

            //Configuración de SMTP
            $mail->isSMTP();
            $mail->Host = $_ENV['EMAIL_HOST'];
            $mail->SMTPAuth = true;
            $mail->Username = $_ENV['EMAIL_USER'];
            $mail->Password = $_ENV['EMAIL_PASS'];
            $mail->SMTPSecure = 'tls';
            $mail->Port = $_ENV['EMAIL_PORT'];

            //Configuración del correo
            $mail->setFrom('admin@bienesraices.com');
            $mail->addAddress('admin@bienesraices.com', 'BienesRaices.com');
            $mail->Subject = 'Tienes un Nuevo Mensaje';

            //Habilitar HTML
            $mail->isHTML(true);
            $mail->CharSet = 'UTF-8';

            //Contenido del correo
            $contenido = '<html>';
            $contenido .=' <p>Tienes un nuevo mensaje</p>';
            $contenido .=' <p>Nombre: '. $respuestas['nombre'] . '</p>';
            

            //Enviar de forma condicional campos
            if($respuestas['contacto'] === 'telefono'){
                $contenido .= '<p>Eligió ser contactado por teléfono</p>';
                $contenido .=' <p>Telefono: '. $respuestas['telefono'] . '</p>';
                $contenido .=' <p>Fecha: '. $respuestas['fecha'] . '</p>';
                $contenido .=' <p>Hora: '. $respuestas['hora'] . '</p>';
            }else{
                $contenido .= '<p>Eligió ser contactado por email</p>';
                $contenido .=' <p>Email: '. $respuestas['email'] . '</p>';
            }

            
            $contenido .=' <p>Mensaje: '. $respuestas['mensaje'] . '</p>';
            $contenido .=' <p>Vende o Compra: '. $respuestas['tipo'] . '</p>';
            $contenido .=' <p>Precio o Presupuesto: $'. $respuestas['precio'] . '</p>';
            $contenido .=' <p>Tipo de contacto: '. $respuestas['contacto'] . '</p>';
            $contenido .= '</html>';

            $mail->Body = $contenido;
            $mail->AltBody = 'Este es el contenido en formato HTML';

            //Enviar el correo
            if ($mail->send()) {
                $mensaje = 'Mensaje enviado correctamente';
            } else {
                $mensaje = 'Mensaje enviado correctamente';"El mensaje no se pudo enviar. Por favor, revise los datos de entrada";
            }

        }
        $router->render('paginas/contacto',[
            'mensaje' => $mensaje
        ]);
        
    }
}
