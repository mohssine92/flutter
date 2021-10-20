// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';



class DetailsScreen extends StatelessWidget {

  
  const DetailsScreen({ Key? key }) : super(key: key);

 

  @override
  Widget build(BuildContext context) {

     // al redericcionar a esta pantalla mandamos arg y pude ser cualquier tipo de arg _ ahora necesito ser capaaz de recibirlo
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie; // tratelo como Movie
     // ? : puede ser null , ?? condicionaa sino 'no-movie'


    

    return Scaffold( // page

      body: CustomScrollView( // la difrenecia este tiene slivers me permite hacer appbar en scroll y perzonalizado
         slivers: [
            _CustomAppBar(movie),
            //ex text() esa widget normal como lo demas aqui solo puedo poner widgets de la familia de slivers asi voy occupar
            // sliver list es espacio me permite ponerle dentro widget normales.
            SliverList( // lista cual donde puedo meteer mi widgets normales en la prop delegate
              delegate: SliverChildListDelegate([
                 
                _PosterAndTitle( movie ),
                _Overview( movie ),
                _Overview( movie ),
                _Overview( movie ),
                CastingCards( movie.id ) // opcion cuando buildcontext disparado llamr metodo de nuestro provider imediamente caga actores podria ser un camino 
                                     // nosostros hacemos le mando movie.id de pelicula y internamente del widget castingCard cargue actores basados en ese id


              ])
               

             
              
            )
         ],
      )
    );
  }




}

// otro widget pezonalkizado appbar perzobalizado y afectado por scroll

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar( this.movie );  // posicional obligatorio

  @override
  Widget build(BuildContext context) {
    //var movie;

    return SliverAppBar( // youtube hay muchos slivers
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true, // llega un punto donde de dejar de moverse hacia arriba
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0), // come padding que tiene title prop 
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only( bottom: 10 , left: 10 , right: 10 ),
          color: Colors.black12, // imporane color transparente sino pierdo img de background
          child: Text(
             movie.title,
             style: TextStyle( fontSize: 16 ),
             textAlign: TextAlign.center, 
          )
        ), 
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage( movie.fullBackdropPath ),
          fit: BoxFit.cover, // se expanda todo pueda respeto al padre sin perder dim3ensiones de la misma img
        ),
      
         
      
      ),

    );
  }
}


// estos widgets son privados van a vivir solo detro del widget DetailsScreen
// se usan en delegate evitamos extensidad de codigo . 

// poster y titulo depelicula 101
class _PosterAndTitle extends StatelessWidget {

  
  final Movie movie;

  const _PosterAndTitle( this.movie );


  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme; // asi no repetimos bastante ..
    final size = MediaQuery.of(context).size;


     return Container(
      margin: EdgeInsets.only( top: 20 ),
      padding: EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!, // same id in widget de entes cumple la animacion 
             child:  ClipRRect( // to add border 
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage( movie.fullPosterImg ),
                height: 150,
              ),
            ),
          ),

          SizedBox( width: 20 ),

          ConstrainedBox( // for control wisth colomn
            constraints: BoxConstraints( maxWidth: size.width - 190 ),
             child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text( movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2 ),
                
                Text( movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),

                Row(
                  children: [
                    Icon( Icons.star_outline, size: 15, color: Colors.grey ),
                    SizedBox( width: 5 ),
                    Text( '${movie.voteAverage}', style: textTheme.caption )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );


 

    
  }
}


// descripcion de la pelicula y actores
class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 10),
      child: Text(movie.overview,
       // movie.overview,
       textAlign: TextAlign.justify,
       style: Theme.of(context).textTheme.subtitle1, // se vea un poco mas grande al parrafo
      ),
    );
  }
}



