import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
//import 'package:peliculas/models/models.dart';


class MovieSlider extends StatefulWidget{


  final List<Movie> movies;
  final String? title;
   final Function onNextPage;

  const MovieSlider({
    Key? key,
    required this.movies,
    required this.onNextPage, // recibo por nombre cualquier data paginada , asi este scrollcard reutulizable 100%
    this.title
    
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState(); // necesita estar sujeto a un widget que tiene scroll

}

class _MovieSliderState extends State<MovieSlider> { 

  final ScrollController scrollController = new ScrollController();

  @override 
  void initState() {  // ejecuta scope la primer vez que este widget es construido 
    super.initState();
    
    scrollController.addListener(() {

      if ( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ) { // restar cuando este cerca al final del scrol maximo 
        // llamar provider
        widget.onNextPage();
      }
  

    });

  }


  
  @override 
  void dispose() { // ejecuta scope cuando widget va ser distruido
    


    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
   
    final size = MediaQuery.of(context).size;
    
     if( widget.movies.isEmpty  ) { // segnifica nou hay movies toda ene spera de la resulucion de la hhtp request provider
    
       // ignore: sized_box_for_whitespace
       return Container(
          width: double.infinity, // ihaul que widget que va terminar redirizando abajo 
          height: size.height * 0.5,
          child: const Center(
            child: CircularProgressIndicator(), // loading
          ),
       );
    } // antes de la construccion del swiper , porque en un instante la coleccion es vacia swiper rewuire 3 elementos sino se bloque la app
      // evito err  _MoviePoster( movies[index] )
  
  

    return Container(
      width: double.infinity,
      height: 260, 
      //color: Colors.red, // ver bien el espacio donde esetoy trabajando  
      child: Column( // necesito colocar widget uno debajo de otro  dfel children prop
        crossAxisAlignment: CrossAxisAlignment.start, // abarca principi a a la izquierda
        children: [

         if( widget.title != null) // evitamos err title no se puede ser renderizada cuando es null - condicioanl no cumpla no mostrar padding widget 
          Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.symmetric( horizontal: 20 ), // pading only horizontal
              // ignore: prefer_const_constructors
              child: Text( widget.title! , style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold ),),
          ),

          const SizedBox( height: 5 ), // sepaRACION


    
          Expanded( // lo que hace toma todo espacio disponible en el padre column
            child: ListView.builder( // ciclo - esta conatruido tarjetas populares
              controller: scrollController,
              scrollDirection: Axis.horizontal, // quiero scrool lo haga verticalmente
              itemCount: widget.movies.length, // lenght coleccion a ciclar 
              // la prop llamada para la construccion del mismo 
              itemBuilder: (_, int index) => _MoviePoster( widget.movies[index] , '${ widget.title }-$index-${ widget.movies[index].id }' ),
               // mandar instancia correspondiente al posicion index
            ),
          )

        ]

  
      )

    );
     
    
    
  }
}

// vamos a crea este nuevo widget porque el widget  de arriba esta muy cargado sera deficil de leer
// este widget no meneja estado sera privado _ porque no voy a exportarlo al mindo exterior solo va a vivir dentro del 
// widget _MovieSlider para facilitar leer evitar codigo extendo


class _MoviePoster extends StatelessWidget {

  
  final Movie movie;
  final String heroId;

  const _MoviePoster( this.movie , this.heroId ); // arg posicional 109


  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId; 
   

   return Container(
     width: 130,
     height: 190,
     //color: Colors.green, fue anadida solo parea ver espacion donde desaroloo
     margin: const EdgeInsets.symmetric( horizontal:10 ),
     child: Column(
       children:  [

         GestureDetector( // tema de ontap hacer algo definido 
           onTap: () => Navigator.pushNamed(context, 'details', arguments: movie ),
           child: Hero( 
             tag: movie.heroId!, // ventaja de tavajar con modelo
             child: ClipRRect( // tema de border
               borderRadius: BorderRadius.circular(20),
               child: FadeInImage(
                 // ignore: prefer_const_constructors
                 placeholder: AssetImage('assets/no-image.jpg'),
                 image: NetworkImage(movie.fullPosterImg),
                 width: 130,
                 height: 190,
                 fit: BoxFit.cover,
               ),
             ),
           ),
         ),
      
         const SizedBox( height: 5), // separacion


          Text(
            movie.title, 
            maxLines: 2, // when rich final creat new line
            overflow: TextOverflow.ellipsis, // resolve prob text largo with ...
            textAlign: TextAlign.center,
         ),

       ]
     )

   );

    
     
  }
} 


// la idea movie_slider sea lo mas reutulizable posible . 
// dia maña queremos poner row de peliculas bajo rows de pelicula y bajo row de otro productos
// tenemos que ser capaces de reutulizar hasta donde sea posible