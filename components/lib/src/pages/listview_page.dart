import 'package:flutter/material.dart';

import 'dart:async';


// widget muy importante en cualquier app que trabaja con listas
// este widget listViewBuilder va ayudarme a trabajar con refresher y infinit scroll


class ListaPage extends StatefulWidget {
  const ListaPage({Key? key}) : super(key: key);

  @override
  _ListaPageState createState() => _ListaPageState();
}


class _ListaPageState extends State<ListaPage> {

  // controlador del scrool de la ista - debo asociar la instancia a un ListViewBuilder
  final ScrollController _scrollController = ScrollController(); // controlador de lista  86

  // ignore: prefer_final_fields
  List<int> _listaNumeros =[];
  int _ultimoItem = 0; 
  // ignore: unused_field
  bool _isLoading = false;


   
   @override // hay que sobre escribirlo porque quiero ejecutar el codigo en un instante 
   void initState() { // iniciar state en una etapa de creacion de statefullwidget  : ciclo de vida de creacion de statefullwidget
     super.initState(); // este super hace referencia a la clase state y lo inicializa  
     _agregar10(); 
    
    
   /* agregar un listerner a este scrollcontroller - puesto est ainicializado lister ya esta escuchando durante la vida de este
      statefullwidget se dispara cada vez mueve scroll pero la idea no poner una condicion cuando alcanza final del scroll */   
     _scrollController.addListener(() {
       
        // scrol tiene varios valores interesantes : posicion actual en pixeles - .. maximo en pixeles
       if( _scrollController.position.pixels == _scrollController.position.maxScrollExtent ) {
          // _agregar10(); trae data al instate 
          fetchData(); // trae data atraves de peticion http lo cual tenemos un dilay de algunos ms. 
       }
     
     });
 
   }

   @override
   void dispose() { // se dispara cuando el statefulwidget : pagina de destrice : salir de ella
     super.dispose();

     _scrollController.dispose(); // asi evito muchos listeners , prevenir fugas de memoria
   }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas'),
      ),
      body: Stack( // igual que column etc.  stack uno ecima del otro
        children: <Widget>[
          _crearLista(),
          _crearLoading()
        ],
      ) 
      
      
    );
  }

  Widget _crearLista() {

      return RefreshIndicator( // debe evolver un widget de scroll
        
        onRefresh: obtenerPagina1,

        child: ListView.builder( // encarga de renderizar los elementos conforme necesarios - no sabemos cuanto son muchos 
          controller: _scrollController, //ref a scroll - permite ami poder mover de poscion es igual a lo del input para append..
          itemCount: _listaNumeros.length, // cuantos elementos tiene esta lista  en ese instante - 
          itemBuilder: (BuildContext context, int index ){ // index las posicion que esta creando en este instante builde ..
      
            final imagen = _listaNumeros[index];
      
            return FadeInImage( // yaqeu cargar de servicios externos para añadir loading - creara indexes de  FadeInImage()
              image: NetworkImage('https://picsum.photos/500/300/?image=$imagen'),
              placeholder: const AssetImage('assets/jar-loading.gif'), // loading
            );
          },
        ),
      );
  

  }
 
  // cada vez llamo a ese metodo va a agregar 10 imagenes a la lista 
  void _agregar10() {

    for (var i = 1; i < 10; i++) {
      _ultimoItem++;
      _listaNumeros.add( _ultimoItem );
    }

    print(_listaNumeros);

  
    setState(() {}); // la idear cada vez auementa la coleccion depende de ella trae imgs redibujamos statefullwidget

  }

  Future fetchData() async {  
     _isLoading = true;
     setState(() {}); // actualizar dom - mostrat algun widget encargado de mostrar loadind depende _isLoading() 
     const duration =  Duration( seconds: 2 );
     return Timer( duration, respuestaHTTP );  // se cumpla ese duration ejecuta callback
  }

  void respuestaHTTP() {

    _isLoading = false; // ya pasado 2s ya termino decargar

    _scrollController.animateTo( // mover un poco scrol al cargar mas elemento ,ver que hat mas elementos
      _scrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn,
      duration: const Duration( milliseconds: 250)
    );

    _agregar10(); 

  }
  Widget _crearLoading() {

     if ( _isLoading ) {
       return Column(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: const <Widget>[
               CircularProgressIndicator() // circulo
             ],
           ),
           const SizedBox( height: 15.0)
         ],
       );
       
       
       
     } else {
       return Container(); //vacio 
     }

  }
  
  Future obtenerPagina1() async {
  
      const duration = Duration( seconds: 2 ); // onRefresh : la idea tener solo nuevos siguientes registros desde ..refresh arrastrar de arriba hacia abajo 
      Timer( duration, () {
  
        _listaNumeros.clear();
        _ultimoItem++;
        _agregar10(); // implemete actualizar setstae
  
      });
  
      return Future.delayed(duration);
  
  }



















 // void _agregar10() {
//
 //   for (var i = 1; i < 10; i++) {
 //     _ultimoItem++;
 //     _listaNumeros.add( _ultimoItem );
 //   }
//
 //   setState(() {});
//
 // }


 
   


}