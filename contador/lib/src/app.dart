
import 'package:contador/src/pages/contador_page.dart';
import 'package:flutter/material.dart';





// este archivo va contener toda la logica de mi MaterialApp() widget



// todos widgets son clases comun y corriente
// hay dos tipo de widgets , nuestra clase normal extiende caracteriticas de un widgets pues se convierte en widget de tipo satelwesswidget
class MyApp extends StatelessWidget {
 

  const MyApp({Key? key}) : super(key: key);
  // Myapp : constructor - super constructor de la clase la cual extendemos
  // es decir lo que recibo en este constructoe lo mando allamar a constructor clas padre
  // : indicando lo que quiero ejecutar al momento de instancia de esta clase



  @override // con este comando nos vamos a sobre escribir el metodo extendida
  Widget build( context ) { // un metodo build el cual es encargado de dibujar este widget - metodo debe cumplir requisitos de  StatelessWidget.build (como interfaz) 

     // context contiene informacion de arbol de widgets , informacion del tema y de la familia
   
    return const MaterialApp( // MaterialApp : es un widget que permite la configuracion global de mi applicacion 
      debugShowCheckedModeBanner: false,
      // home:HomePage() //my class - route
      home:ContadorPage() 
      
      /* props ... */
     
    );


  } // este metodo returna el tipo Widget a fuerza
   
}               


// asi podemos por entender un widget es una clase recibe args en su constructor al instanciar el mismo widget 
// asi las props cumplen un tipado , la mayoria de veces el tipado va ser de otros widget asi la sintaxis que tendremos es widget dentro widget
// es decir como clase dentro de clase etc...
// como es el caso de hemos por ejemple necesita un texto asi implementamos un widget text() que recibe strig o nos da su producto y queremos posicionarlo en medio
// pues el widget text debe implementarlo dentro de un widget center() que centraliza en la pantalla un producto de un widget en este caso producto de un widget text que sera un string

/* cuando ejecuto un widget occupo mandar argumentos definidos en su constructor sea posicinal o por nombre */


/* ! confia en mi 

  soy variable ?? si no llega ejecutame  */