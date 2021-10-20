// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:preferenciasusuario/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasusuario/src/widgets/menu_widget.dart';







class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
  
  // tres prop que manejamos sus estados 
  bool? _colorSecundario;
  int? _genero;
  String _nombre = '';

  // prop de tipo ... para controalar input
  // como lo inicio en el init state en breve , le pongo late es decir cuando lo vas a utulizar flutter ya va a tener un valor : late  
  late TextEditingController? _textController;

  final prefs = PreferenciasUsuario(); 


  // satteful widget tiene un aparte de su ciclo de vida llama init state , se dispara cuando se inicaliza ese estado del widget
  // se dispara antes del build
  @override
  void initState()  { // init state no implementa asyn await error
    super.initState();

    
    prefs.ultimaPagina = SettingsPage.routeName; // setter
    _genero = prefs.genero; // getter
    _colorSecundario = prefs.colorSecundario; // getter

    _textController = TextEditingController( text: prefs.nombreUsuario); // _nombre 
  }
  

  
  
  
  _setSelectedRadio( int? valor ) async {
   
    prefs.genero = valor ?? 0;  // si no viene valor le asignas 0 : evaluacion setter 
    _genero = valor;
    setState(() {}); // cambio un estado pues redibujo

  }



  
  @override
  Widget build(BuildContext context) {

   // prefs.ultimaPagina = HomePage.routeName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold )),
          ),
          
          Divider(),

          SwitchListTile(
            value: _colorSecundario?? false, // si es null por defalt es false
            title: Text('Color secundario'),
            onChanged: ( value ){ // value en este nivel sera opuesto
              //print(value);
               setState(() {  // redibujar - estamos modificando states
                 _colorSecundario = value;
                 prefs.colorSecundario = value; // setter
               });
            },
          ),

          RadioListTile(
            value: 1, // int
            title: Text('Masculino'),
            groupValue: _genero ,
            onChanged: _setSelectedRadio, // recibe int
          ),

          RadioListTile(
            value: 2, // int
            title: Text('Femenino'),
            groupValue: _genero ,
            onChanged: _setSelectedRadio, // no necito poner arg , automaticamente lo que emita onchanged pasa como 1 arg
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0), // no pegado a los bordes
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el teléfono',
              ),
              onChanged: ( value ) { // saber lo que la persona escribio 
                 prefs.nombreUsuario = value;
              },
            ),
          )


        ]
      ),
    );
  }
}


