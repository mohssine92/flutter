import 'package:flutter/material.dart';
import 'package:components/src/providers/menu_provider.dart';
import 'package:components/src/utils/icono_string_util.dart';
//import 'package:components/src/pages/alert_page.dart';



//import 'package:componentes/src/providers/menu_provider.dart';

//import 'package:componentes/src/utils/icono_string_util.dart';

//import 'package:componentes/src/pages/alert_page.dart';


class HomePage extends StatelessWidget {
 
  const HomePage({Key? key}) : super(key: key);

  
  
  
  @override
  Widget build(BuildContext context) { // pintar windget sw widgets en pantalla
    return Scaffold( // pantalla completa 
      appBar: AppBar(
        title: const Text('Componentes'),
      ),
      body: _lista(), 
    );
  }

   // cuando vean builder entender que es algo que va permitir debujar algo en la pantalla del dispositivo

  Widget _lista() {


    return FutureBuilder( // es un widget permite dibujarse asi mismo basado en last snapshot que actue con el future 

      future: menuProvider.cargarData(), // future a resolver promise
      initialData: const [], // data por defect mientras no se ha resuelto este future es opcinal - evitar null siempre tenga algo como [] vacia
      builder: ( BuildContext context, AsyncSnapshot<List<dynamic>> snapshot ){ // builder requerida props - 
         // builder debe regresar un widget
        //print(snapshot.data);
        return ListView(
          children: _listaItems(  snapshot.data! , context ),
        );

      },//este builder se va a dispara en varias etapas - una cuando estoy pidiendo data-2 cuando optuvo la data -3 cuando tenemos algun err


    );
   
   


   
   // return ListView(
   //   children: _listaItems(), // children need list of items widget accept repetition some widget
   // );

    
  }

  List<Widget> _listaItems( List<dynamic> data , BuildContext context ) { // regresa items
     
    final List<Widget> opciones = [];

    for (var opt in data) {

       final widgetTemp = ListTile( //1  li
         title: Text( opt['texto'] ),
         leading:  getIcon( opt['icon']), //67 my function 
         trailing: const Icon ( Icons.keyboard_arrow_right, color: Colors.blue ),
         onTap: () { // clcik dispar.. action has implemented en the scope
           // navigar pantallas : 69-69-70  
           // context sabe toda informacion pagina anterior y pagina pongo encima
         
        
            // forma de navigacion 69 -
            Navigator.pushNamed( context, opt['ruta']); // opt['ruta'] => seria como : home/ product/ etc ..
            //  main.dart config que pagina derige al recibir opt['ruta'] - comentamos home : routa por defecto
            // opt['ruta'] => este string debe estar definido en routes <string> sino falla





           // forma de navigacion  69
           /*  final route = MaterialPageRoute( 
             builder: ( context )=> const AlertPage()
           );
            Navigator.push( context, route );  */
 
         },
       );
 
       opciones..add( widgetTemp ) // ..add ..add dos punt encadenar push  
               ..add( const Divider() );

    }

    return opciones; // porque children recibe list de widgetsen este caso de ListTitle()



  
  }

 
 


}


// leer archivo json - prover la informacion como map - usar futurbuilder - mostrar en pantalla widget de widgets es todo hecho en este ciclo


