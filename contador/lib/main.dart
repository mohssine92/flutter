
import 'package:flutter/material.dart'; // imporatacion para uso de la funcion runApp()


// Nosotros escribimos
import 'package:contador/src/app.dart';




// recuerda estamos programando con dart asi todo se ejecuta dentro de funcion ,main  punto de inicio 
// framework busca dentro del archivo main la funcion main 
void main() {

 // dicerle a fluter corra mi app : primer comando de fluter que vamos usar runApp , cuando ejecuta la programa va buscar esta funcion 
 runApp( const MyApp());  // MyApp es un widget : clase princiapl - mi applicion 

}


