import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_qr/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context); // instancia al singlton del tipo... impleme notify
    // si viene dentro de un metodo un funcion , viene asi contextt, listen: false , paraque no intente de redibujar da err
    
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: ( int i ) => uiProvider.selectedMenuOpt = i, // seter - i es index del button tapeada no hacemos (i) poruqe no es metodo
      currentIndex: currentIndex, // selecionar botton del index obtenido desde eñ provider
      elevation: 0,
      items: <BottomNavigationBarItem>[ // minimen 2 items
        BottomNavigationBarItem(
          icon: Icon( Icons.map ),
          label: 'Mapa'
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.compass_calibration ),
          label: 'Direcciones'
        ),
      ],
    );
  }
}

