import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:app_qr/pages/home_page.dart';
import 'package:app_qr/pages/mapa_page.dart';

import 'package:app_qr/providers/ui_provider.dart';
import 'package:app_qr/providers/scan_list_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider( // es como singlton tener instacia para consumir desde los widgets del arbol 
      providers: [ // implemenatn notify - tener instancia desde este nivel - accedida por cualquier widget 
        ChangeNotifierProvider(create: (_) => UiProvider() ),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
          title: 'QR Reader',
          initialRoute: 'home',
          routes: {
            'home': ( _ ) => HomePage(),
            'mapa': ( _ ) => MapaPage(),
          },
          theme: ThemeData( // 149tema de la app global
            primarySwatch: Colors.cyan,
            //floatingActionButtonTheme: FloatingActionButtonThemeData(
            // backgroundColor: Colors.deepPurple
            //)
            //appBarTheme: const AppBarTheme(
            //  color: Colors.deepPurple // cambiar color del app bar de forma global en la app 
            //)
          ),
         
      ),
    );
  }
}

