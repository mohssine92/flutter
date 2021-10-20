// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';





/* StatefulWidget se compone de dos clases */




class ContadorPage extends StatefulWidget {
 
  const ContadorPage({Key? key}) : super(key: key);

   
  @override 
  createState() => _ContadorPageState(); 
  // nesecita returnar nueva instancia de mi ...
  
  


  
}



//estado de este statefullWidget : el etado que va manejar 
// state que manejar contador Page
// no se usa fuera de este archivo _ privado 
class _ContadorPageState extends State<ContadorPage> {
  
  final _estiloTexto = const TextStyle( fontSize: 25 );
  
   int _conteo = 0;
  
  @override  
  Widget build(BuildContext context) { 
  
  
    return Scaffold( // widget pantalla 
      //props de Scaffold 

      appBar: AppBar( // widget barra superior 
        
        title: const Text('satatefull'), // pinta texto string en el cuadro AppBarr
        centerTitle: true, 

      ), 
      body: Center(  //...  cuerpo , centraliza widget implementado en child
            
        child: Column(

           mainAxisAlignment:  MainAxisAlignment.center, // de tipo es decir instacia tipo y accede a prop del tipo ver resultado
           children: <Widget>[
             Text( 'Número de taps:', style: _estiloTexto ),
             Text( '$_conteo'  , style: _estiloTexto ), /* $valor variable '' convertir number en string */
           ],
        )

      ), 
      floatingActionButton: _crearBotones(),
       // ubicacion button 
     
    ); // widget pantall - tiene limitados widget a mostrar en pantall segun props de su constructor  en este caso usamos tres
  }



  //implemenat funcion antes del cierre de la clase
   Widget _crearBotones() {
         
     // row y column widget pararetuenar en este varios botones   

      return Row(
        mainAxisAlignment: MainAxisAlignment.end, // desplazar els set del row
        children: <Widget>[ // todos widgets colocar de manera horizontal
          
          // ignore: prefer_const_constructors
          SizedBox( width:30.0 ),
          FloatingActionButton( child: Icon(Icons.exposure_zero), onPressed: _reset),
          Expanded(child: SizedBox() ), // separacion 
          FloatingActionButton( child: Icon(Icons.remove), onPressed: _sustraer ), // _remove : sejecuta al dar clcik - _remove()sejecuta.. 
          SizedBox( width: 5.0 ), // separacion 
          FloatingActionButton( child: Icon(Icons.add ), onPressed: _agregar ),
             
        ],
      );
      
   }


   void _agregar (){  
     setState(() => _conteo++ ); // setState redibuja widget cuando se cambia la dependencia _conteo
     // para redibujar
   }
   void _sustraer (){  
     setState(() => _conteo-- );
     // para redibujar
   }
   void _reset (){  
     setState(() => _conteo = 0  );
     // para redibujar
   }





  
   


}