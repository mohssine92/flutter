import 'package:flutter/material.dart';

import 'package:preferenciasusuario/src/pages/home_page.dart';
import 'package:preferenciasusuario/src/pages/settings_page.dart';



class MenuWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer( // icon de haburguesa
     //any widget sirva para rellenar informacion  - list view para poder hacer scroll si hat mas widgets elements
      child: ListView( 
        padding: EdgeInsets.zero, // marfin anteriro fuera
        children: <Widget>[
          DrawerHeader( // 
            child: Container(),
            decoration: BoxDecoration( /// viene como fondo
              image: DecorationImage(
                image: AssetImage('assets/menu-img.jpg'),
                fit: BoxFit.cover // expanda todo ancho posible
              )
            ),
          ),
           // ipciones del menu 
          ListTile(
            leading: Icon( Icons.pages, color: Colors.blue ),
            title: Text('Home'),
            onTap: ()=> Navigator.pushReplacementNamed(context, HomePage.routeName ) ,
          ),

          ListTile(
            leading: Icon( Icons.party_mode, color: Colors.blue ),
            title: Text('Party Mode'),
            onTap: (){ },
          ),

          ListTile(
            leading: Icon( Icons.people, color: Colors.blue ),
            title: Text('People'),
            onTap: (){ },
          ),

          ListTile(
            leading: Icon( Icons.settings, color: Colors.blue ),
            title: Text('Settings'),
            onTap: (){
               //Navigator.pop(context); // cerra menu 
              Navigator.pushReplacementNamed(context, SettingsPage.routeName  ); // cierra menu y telleva a una pagina donde no puedees regresar 
              //esto nos ayuda cuando alguien hace login y no queremos que se regresa a la pantalla anterior
            }
          ),

        ],
      ),
    );
  }
}


// centralizar de nuestro menu lateral com widget o no como una funcion , porque widget consta de build donde tenemos context asi no tenomos que pasar para tema de navigacion
// tenerlo centralizado es  facil de usar en cualquier widget page requiero el menu