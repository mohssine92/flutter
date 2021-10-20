import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';


import 'package:components/src/routes/routes.dart';
import 'package:components/src/pages/alert_page.dart';








void main() => runApp(const MyApp());



class MyApp extends StatelessWidget {
 
  const MyApp({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       localizationsDelegates: const [  // configuracion de idioma  fecha calendar desplegado  video 81
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English - variables soportadas
        Locale('fr', 'FR'),
      ],
      //home: HomePage(), // pagina statica a servir por defecto 
      initialRoute: '/',
      routes: getApplicationRoutes(),  //69
      onGenerateRoute: ( RouteSettings settings ){ // seejecuta solamente cuando la ruta llmada no esta definida en la mapa de routes
       
        print( 'Ruta llamda: ${ settings.name }' ); // settings.name  ruta dinamica clickeada

        return MaterialPageRoute( // 70
          builder: ( BuildContext context ) => const AlertPage()
        );


      },
       

    );
  }
}