
import 'dart:async'; // stream

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/edboucer.dart'; 

// importacion de los modelos
import 'package:peliculas/models/models.dart';






// mi provedeor de informacion instacia accedia por cualquier widget class atraves de context 
// provider se base de tener comunicacion con servicios externos usando paquete http - 
// hay que pensar : mi instacia de este provider debe ser global es decir toda la app debe tener acceso al mismo si la respuesta es si , debe estar en un punto bastante alto de la app
// es decir un punto alto de mi arbol de wigdet quiero decir de mi context y si el provider lo necesita solo un screnn pues lo intanciamos alli 
// paraque sea un provider tenego que extender de ... sino sera un aclase normal corriente

class MoviesProvider extends ChangeNotifier {

  // props privadas
  final String _apiKey   = 'ebdcb0209f685902d02cebb6c7b97c8f'; // my key created por mi 
  final String _baseUrl  = 'api.themoviedb.org'; // https no hace falta porque Uri.https lo va colocar por mi 
  final String _language = 'en-EN';


  List<Movie> onDisplayMovies = []; // en widgets , estar pendiente de este list , estar escuchando 
  List<Movie> popularMovies   = [];


  Map<int, List<Cast>> moviesCast = {}; // llave id pelicula 

  int _popularPage = 0;


  final debouncer = Debouncer(
    // ignore: prefer_const_constructors
    duration: Duration( milliseconds: 500 ),
  );


  final StreamController<List<Movie>> _suggestionStreamContoller = StreamController.broadcast(); // falta mandar valores a estre streama abierto en algun lugar
  Stream<List<Movie>> get suggestionStream => _suggestionStreamContoller.stream;  // va ser un getter



  // constructor
  MoviesProvider() {
    
     getOnDisplayMovies();
     getPopularMovies();

  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async { // int page  obligatorio
                                                                          // [int page = 1] opcional si no se manda pues sera 1
    final url = Uri.https( _baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  // en este punto voy a realizar peticion http usando paquete http recien instaled 104 - 105
  getOnDisplayMovies() async  {


     final jsonData = await _getJsonData('3/movie/now_playing');

     final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData); // nowPlayingResponse : data a consumir en nuestros componentes
     //print(nowPlayingResponse.results[1].genreIds);
    
     onDisplayMovies = nowPlayingResponse.results;
    
     notifyListeners();
  }

  getPopularMovies() async { //108

     _popularPage++; //110

    // print(_popularPage);

    final jsonData = await _getJsonData('3/movie/popular', _popularPage );

    final popularResponse = PopularResponse.fromJson(jsonData);
    
     
     popularMovies = [...popularMovies ,...popularResponse.results];
     // destructurin para mantener reesultados actuales , voy a llamar a varias paginas 1, 2 , 3 etc .. comoes coleccion vacia ..

    
     // este metodo sujeto a cambio de valores de la prop de la clase , notifyListeners(); dice a todos widgets escuchando sucede un cambio en la dat redibujame : metodo de provider
     // solo redibuja lo necesario solo los valores que cambio 
     notifyListeners();

   
  }

   Future<List<Cast>> getMovieCast( int movieId ) async {

    
    // Mostrar actores y mantener en memoria
    if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

   // print('ask data of the server');

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson( jsonData );


    // rellenamos map que hemos definido en props . asi sera facil la busqueda con id 
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  } // este future debe ser disparado en algun lugar

  Future<List<Movie>> searchMovies( String query ) async {

    final url = Uri.https( _baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson( response.body );

    return searchResponse.results;
  }


  void getSuggestionsByQuery( String searchTerm ) { // meto valor query al stream , obviamente cuando lapersona deje de escribir

    debouncer.value = ''; // set - string vacio nunca seve consola porque scope global requier teclas para disparse
    debouncer.onValue = ( value ) async { 
      //print('Tenemos valor a buscar: $value');
      final results = await searchMovies(value);
      _suggestionStreamContoller.add( results ); // emit valor : add new event on our stream  - respect de tipe
    }; // async porque debo resolver un futur para traer data http request 

    // ignore: prefer_const_constructors
    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) {  // x tiempo se dispara una vez porque lo voy acancelar 1ms despues
      debouncer.value = searchTerm; // set ejecuta internamente onvalue deinida arriba
    });

    // ignore: prefer_const_constructors - evitar 2 y 3 ... dispares, prefer_const_constructors
    Future.delayed(Duration( milliseconds: 301)).then(( _ ) => timer.cancel());
  }








} // es un objeto provider puedo acceder a cualquir de sus metodos y props puesto que no sean privadas












