
import 'package:flutter/services.dart' show rootBundle; //imprt necesary for read file json 
// exporto solo lo que necesito o hacer visible rootBundle:object

import 'dart:convert'; //json decode




class _MenuProvider {

  List<dynamic> opciones = []; // any dynamic

  _MenuProvider() { // constructor
    // cargarData(); no puedo es un promise asi no puedo implementar asyn await en construcor
  }

  Future<List<dynamic>> cargarData() async {

    final resp = await rootBundle.loadString('data/menu_opts.json');   // future es promise
    
    
 
      Map dataMap = json.decode( resp );  // 65 - convertir json string a un Map:objeto js 
      opciones = dataMap['rutas'];
      
    
      
      return opciones;

  }

}



// de esta menera este archivo solo expone instancia de _MenuProvider(); 
final menuProvider = _MenuProvider(); 



// no es importante la exportacion ,solo la imporacion del archivo 