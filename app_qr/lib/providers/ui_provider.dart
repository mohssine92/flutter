import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier { // ChangeNotifier requerido 

  int _selectedMenuOpt = 1; // esta prop para saber indice seleccionado - body condicional

 // getters 
  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }


  // setters
  set selectedMenuOpt( int i ) {
    _selectedMenuOpt = i;
    notifyListeners(); // por eso usamos getter y seters  // notificar a cualquier widget esta escuchando a ese provider los cambios

  }


} 