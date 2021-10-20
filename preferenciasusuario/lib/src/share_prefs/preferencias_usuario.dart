import 'package:shared_preferences/shared_preferences.dart';





 // patron singlton : necesito tene esta instancia antes de dibujar statelesswidget , para no tener que impelemnatr async en lugares prohibidas
 // asi patron singlton me permite maneja instancia unica de estas preferewncias de usuario 
 class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  // constructor normal , cuando se ejecuta returna instancia ya creada , no importa donde haga new returna la misma instancia con data centralizada
  factory PreferenciasUsuario() { 
    return _instancia;
  }

  PreferenciasUsuario._internal();


  late SharedPreferences _prefs; // tipo para grabar en storage , late es decir  cunado lo usas tendra valor



  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }


  // GET y SET del Genero
  int get genero {
    return _prefs.getInt('genero') ?? 1; // si no existe genero por defecto sera 1 - caso de primera carga de la app en un dispositivo 
  }

  set genero( int value ) {
    _prefs.setInt('genero', value);
  }

  // GET y SET del _colorSecundario
  bool get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario( bool value ) {
    _prefs.setBool('colorSecundario', value);
  }


  // GET y SET del nombreUsuario
  String get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario( String value ) {
    _prefs.setString('nombreUsuario', value);
  }

    // GET y SET de la última página
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

}

// class para controllar todo estos de prefrencias de user , evitar problema de no tener que hacerlo en sateful widget y esperar los esatdos 


// podemos grabar : token , id user , notificaciones , tema de la app , cosas por el estilo 