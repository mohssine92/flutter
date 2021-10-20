/* mapear resultado de la peticion a una instancia de una classe , por ej si tengo pelicala es como luze pelicula que metodos tiene : quicktype.io */

// ventajas , si back cambia algun prop en el modelo db , esta da err o wornnig asi sabemos directamente dond e resolvemos y yasta 

import 'dart:convert';

import 'movie.dart';


class NowPlayingResponse {


    NowPlayingResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    // las porps
    Dates dates;
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

     // cosntructor por nombre
     // construtor con nombre .fromMap type <string, string> o .from json type string 
    factory NowPlayingResponse.fromJson(String str) => NowPlayingResponse.fromMap(json.decode(str)); // recibe strigyfi : recibe my response http 

   /*  String toJson() => json.encode(toMap()); */ // metodo toma toda instancia de la clase y lo crea como mapa 

     // cosntructor por nombre -
    factory NowPlayingResponse.fromMap(Map<String, dynamic> json) => NowPlayingResponse( // crear instacia de ... ejecuta constructor 
        dates: Dates.fromMap(json["dates"]), // ejecuta facory constructor
        page: json["page"],
        results: List<Movie>.from( json["results"].map((x) => Movie.fromMap(x)) ), // crear listado de movie basados en resultado , mapear coleccion , ejecutar factory constructor
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

   
}

class Dates {
    Dates({
        required this.maximum,
        required this.minimum,
    });

    DateTime maximum;
    DateTime minimum;

    // este factory construcor recibre stringfy -  scope factory constructo recibe mapoa:object
    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    ); // regresa objeto de dates bien formateado 

  
}


