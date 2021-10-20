import 'package:flutter/material.dart'; // uso Icon() widget 

final _icons = <String, IconData>{

  'add_alert'     : Icons.add_alert,
  'accessibility' : Icons.accessibility,
  'folder_open'   : Icons.folder_open,
  'donut_large'   : Icons.donut_large,
  'input'         : Icons.input,
  'list'          : Icons.list,
  'tune'          : Icons.tune,
}; // preparo los icones en funcion de nombree strings recibidos de un recurso 
// recuerda si no preparamos un icon que viene de db aqui no se va a mostrar 




Icon getIcon( String nombreIcono ) { // nombreIcono llave

  return Icon( _icons[nombreIcono], color: Colors.blue );
               // prop posicional puede ser null
  
}


// utils/.. es archivo donde van las funciones que oy a utulizar de forma global en la app
// sabemos para crear un icon debemos llamar un funcion , nuestra data es dinamica de db . asi nombre icon viene en string 
// fluter no acepta de forma directa asi requerimos de esta funcion 



// getIcon() simplemente es un funcion - llamarla en un archivo de la app y imporatr este archivo y pasarla nombre de dinamico 
// obtenido atraves de futurebuilder