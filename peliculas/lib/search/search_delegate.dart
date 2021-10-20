

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/providers/movies_provider.dart';
//import 'package:peliculas/models/models.dart';
//import 'package:provider/provider.dart';
//import 'package:peliculas/providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Search';

 
  @override
  List<Widget> buildActions(BuildContext context) { // clear text input
      return [
        IconButton(
          // ignore: prefer_const_constructors
          icon: Icon( Icons.clear ),
          onPressed: () => query = '',
        )
      ];
  }
  
    @override
    Widget buildLeading(BuildContext context) { // exit search 
      return IconButton(
        // ignore: prefer_const_constructors
        icon: Icon( Icons.arrow_back ),
        onPressed: () {
          close(context, null );
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) { // it show after click enter on input
      
      // ignore: prefer_const_constructors
      return Text('buildResults');
    }

  
  
 

    Widget _emptyContainer() {
      
      // ignore: avoid_unnecessary_containers
      return Container(
          child: Center(
            child: Icon( Icons.movie_creation_outlined, color: Colors.black38, size: 130, ),
          ),
      );
    } 
  
    @override
    Widget buildSuggestions(BuildContext context) { // se dispara cada vez recibe tecla y no eesta vacio input
    
      if( query.isEmpty ) { // input vacio
        return _emptyContainer();
      }
    
     
  

      final moviesProvider = Provider.of<MoviesProvider>(context, listen: false); // no quiero que se redibuja de manera inecesaria - trabajo en base future o stream
      moviesProvider.getSuggestionsByQuery( query ); //send query to strem  - se llama por cada tecla pero ..


      // futreBuilder vs sterambuilder 121 
      // debuncer estar escuchando teclas hasta la persona deja de escribir alli va dispara un valor debouncer 

       return StreamBuilder( // se redibuja unicamente cuando suggestionStream emit un valor
         stream: moviesProvider.suggestionStream, // escuchar ese stream 
         builder: ( _, AsyncSnapshot<List<Movie>> snapshot){ // snapshot result stream or future
        

           if( !snapshot.hasData ) return _emptyContainer();   

           final movies = snapshot.data!; // confia c va teber data 

            return ListView.builder(
               itemCount: movies.length,
               itemBuilder: ( _, int index ) => _MovieItem( movies[index])
      
            ); 
        },

       );

       

   } 

}


class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem( this.movie ); // posicional arg 

  @override
  Widget build(BuildContext context) { // build the list 

    movie.heroId = 'search-${ movie.id }';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
         child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'), 
          image: NetworkImage( movie.fullPosterImg ),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text( movie.title ),
      subtitle: Text( movie.originalTitle ),
      onTap: () {
    
        Navigator.pushNamed(context, 'details', arguments: movie ); // redireccinar with arg 
      },
    );
  }
} 