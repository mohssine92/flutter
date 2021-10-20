import 'package:flutter/material.dart';
import 'package:preferenciasusuario/src/share_prefs/preferencias_usuario.dart';


import 'package:preferenciasusuario/src/widgets/menu_widget.dart';




class HomePage extends StatelessWidget {

  static final String routeName = 'home';

   //apesar que es un singlton lo puedo inicializar en nivel superior en main . y hago la tarea asyncrona en lugar pemitido 
   final prefs = PreferenciasUsuario();

  

  @override
  Widget build(BuildContext context) {

  

    prefs.ultimaPagina = HomePage.routeName; // setter

    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias de Usuario'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(), // menu lateral
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Text('Color secundario: ${ prefs.colorSecundario } '),
           Divider(),
           Text('Género: ${ prefs.genero } '),
           Divider(),
           Text('Nombre usuario:  ${ prefs.nombreUsuario }'),
           Divider()
        ],
      ),
    );
  }


}