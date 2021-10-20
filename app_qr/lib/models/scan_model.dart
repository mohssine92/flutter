//import 'dart:convert';
//import 'package:meta/meta.dart'; // for use metadatos as @required




import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
   

    ScanModel({ // args with name not posicional
        this.id,
        this.tipo,
        required this.valor,

    }) {

      if ( valor.contains('http') ) { // https tambien caea en esta condicion
        tipo = 'http';
      } else { 
        tipo = 'geo';
      }

    }

    int? id;
    String? tipo;
    String valor;

    LatLng getLatLng() { // tipado import del paquete de googlermaps

      final latLng = valor.substring(4).split(','); // cortar del 0 a 4 y de alli creaer list apesar de la separacion ,
      final lat = double.parse( latLng[0] );
      final lng = double.parse( latLng[1] );

      return LatLng( lat, lng ); // tipado esperado por la prop
    }

    //factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory ScanModel.fromJson(Map<String, dynamic> json ) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

    // conver instance of my class to simle map 

    Map<String, dynamic> toJson() => { // lo que hace toma instancia de la classe y lo construye como mapa 
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };
    
}
