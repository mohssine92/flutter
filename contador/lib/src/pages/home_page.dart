import 'package:flutter/material.dart';




class HomePage extends StatelessWidget{

  // props de mi widget pagina
     final estiloTexto = const TextStyle( fontSize: 25 );
     final conteo = 10;

  const HomePage({Key? key}) : super(key: key);


  @override  
  Widget build(BuildContext context) { 
  
  
    return Scaffold( // widget pantalla 
      //props de Scaffold 

      appBar: AppBar( // widget barra superior 
        
        title: const Text('Título'), // pinta texto string en el cuadro AppBarr
        centerTitle: true, 

      ), 
      body: Center(  //...  cuerpo , centraliza widget implementado en child
            
        child: Column(

           mainAxisAlignment:  MainAxisAlignment.center, // de tipo es decir instacia tipo y accede a prop del tipo ver resultado
           children: <Widget>[
             Text( 'Número de clicks:', style: estiloTexto ),
             Text( '$conteo'  , style: estiloTexto ), /* $valor variable '' convertir number en string */
           ],
        )

      ), 
      floatingActionButton: FloatingActionButton( //... boton flotante 
          child: const Icon( Icons.add),
          onPressed: () { // dispare la accion de un button 
       
            // ignore: avoid_print
             print('Hola Mundo!');
            //conteo = conteo + 1; // no podemos - aqui tenemos la necesidad de implementar statefullwidgets
       
          }, 
      ), 
       // ubicacion button 
     
    ); // widget pantall - tiene limitados widget a mostrar en pantall segun props de su constructor  en este caso usamos tres
  }


  

}




// una pagina basicamente es un widget que abarque todo espacio de mi app toda pantalla 

// en metodo build() esta especificado debo regresa un widget , pues returno en este caso un widget scaffold : es una pantalla trae varias widgets ver docs , 


// ver docs : en resumen cada  prop de un widger implementa y tipo y si el caso implementa un widget es decir asu ves consta de muchos props que impelementa tipado asi es ....


// column - row : widget para poner elemento en form acolumnas : uno bajo otro ,  o row : una lado del otro  
// <wifget>[] arreglo de tipo widget . resuelve problema de repeticion de mismo widget : text() por ejemplo
/* child :  Text( 'Número de clicks:', // prop posicional  
                       style: estiloTexto),   */


// floatingactionbuttonlocation: floatingactionbuttonlocation.centerfloat, // se trata cuando tenemos solo un button tendro del scaffold

/*  FloatingActionButton( //... boton flotante 
          child: const Icon( Icons.add),
          onPressed: () { // dispare la accion de un button 
       
            // ignore: avoid_print
             print('Hola Mundo!');
            //conteo = conteo + 1; // no podemos - aqui tenemos la necesidad de implementar statefullwidgets
       
          }, 
      ), */