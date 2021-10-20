import 'package:flutter/material.dart';
//import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatelessWidget {

  
  const HomeScreen({ Key? key }) : super(key: key);




  @override
  Widget build(BuildContext context) {
   
    // magia provider : siempre en el scope de buils - voy a occupar conrtext 
    // es generico no se sabe a que esta apuntando - le paso el tipo provider que tiene que buscar 
    // need go to arbol widgets (context) find instanc always when was defined in the Multiprovider of the providers .
    final  moviesProvider = Provider.of<MoviesProvider>(context); // listen true , por defecto dice al widget redibujate cuando se llame notify listener 
 
    
  

    return Scaffold( // page
      appBar: AppBar(
        title: const Center(child: Text('Películas en cines')),
        elevation: 0, // pegado sin sombre
        actions: [
          IconButton( 
            icon: const Icon( Icons.search_outlined ), // lupita searh
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()), //MovieSearchDelegate clasee reqiere ciertas condiciones
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column( // columna me permite poner widgets uno abajo de otros
          // ignore: prefer_const_literals_to_create_immutables
          children:  [

           // providers : la idea este card se quede reutulizable , asi le mando data , no la manejo internamente  
           CardSwiper( movies: moviesProvider.onDisplayMovies ), // carousel de tarjetas personalizado 

           // va ser lista de tarjetas que van moverse de manera horizontal  slider de peliculas persopnalizado 
           // ver comentarios debajo
           // ignore: prefer_const_constructors
           MovieSlider(
            movies: moviesProvider.popularMovies,
            title: 'Populares', 
            onNextPage: () => moviesProvider.getPopularMovies(),// usada en scroll
           ), 
           //MovieSlider(), 
           //MovieSlider(), 
      
            
      
          ]
      
      
        ),
      )
      

      
     
    );
  }




 

}

//MovieSlider()// ojo si hago otro sale de la dimensiones de la pantalla no tenemos applicado scroll hat varios widget para hacerlo