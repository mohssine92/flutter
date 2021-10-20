import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
//import 'package:peliculas/models/models.dart';
//import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas/models/models.dart';


class CardSwiper extends StatelessWidget {
 
 

  final List<Movie> movies;

  const CardSwiper({
    Key? key,
    required this.movies

  }) : super(key: key); 

  
  
  @override
  Widget build(BuildContext context) {
    
    // me gustaria tomar % de la pantalla por eso uso Mediaquery widget me facilita infromacion relacionada a la plataforma que esta
    // corriendo diemnsiones orientaciones y mucha cosa
    final size = MediaQuery.of(context).size; // en este caso me gustaria saber alto y ancho del despositico

    // ignore: prefer_is_empty
    if( movies.length == 0) { // segnifica nou hay movies toda ene spera de la resulucion de la hhtp request provider
    
       // ignore: sized_box_for_whitespace
       return Container(
          width: double.infinity, // ihaul que widget que va terminar redirizando abajo 
          height: size.height * 0.5,
          child: const Center(
            child: CircularProgressIndicator(), // loading
          ),
       );
    } // antes de la construccion del swiper , porque en un instante la coleccion es vacia swiper rewuire 3 elementos sino se bloque la app
    

   
  

    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity, // todo ancho posible basado en padre: widget donde se encaja en este caso es column  no infinidad
      height:  size.height * 0.5 , //  voy multiplicado por % necesito para el espacio container donde va carrousel 
      //color: Colors.red,
      child: Swiper( // asegura de importarlo del packages que acabamos de installar 
        itemCount:20, // cantida de tarjetas a manejar
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder:( _ , int index) { // es ciclo - itemCount
         // cuando vea builder es algo se va construiendo cuando sea necesario , fuuncion va disparando para cosntruir new widget
         // si no usa BuildContext poner _

          final movie = movies[index];
          
          movie.heroId = 'swiper-${ movie.id }';
        
    
          return GestureDetector( // para que cando ontap sobre un img navigo
           onTap: () => Navigator.pushNamed(context, 'details', arguments: movie ), // 3arg para mandar argumentos
           child: Hero( // animacion 119
             tag: movie.heroId!, // unico en the widget scrren
             child: ClipRRect( // es lo que da borde de la img
               borderRadius: BorderRadius.circular(20),
               child: FadeInImage( // usamos para tener img de loadinng placeholder mientras llega la asyncrona 
                  placeholder:  const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullBackdropPath),
                  fit: BoxFit.cover, // parque se adapte al tamaño caracteristicas del container padre (border)
               ),
             ),
           ),
         );
        },

      ) 
     
    );
  }
}







// => el espacio donde va cardswipper  fin video 96 entender lo de preparar espacio
///: la idea screns de nuestra app quedan mas facil de leer


 /* recuerda context es arbol de widget como se encuetra cosntruido sabes exactamete todo que widget hay antes 
       obviamente de despues no porque aun ni estan construido sabe todo hasta el punto del desarolloque llevamos  */

    