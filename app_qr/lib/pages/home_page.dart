import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



//import 'package:qr_reader/pages/direcciones_page.dart';
//import 'package:qr_reader/pages/mapas_page.dart';

import 'package:app_qr/providers/db_provider.dart'; // !! usado directamente aqui es un siglton 
//import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:app_qr/providers/ui_provider.dart';
import 'package:app_qr/providers/scan_list_provider.dart';


import 'package:app_qr/widgets/custom_navigatorbar.dart';
import 'package:app_qr/widgets/scan_button.dart';

import 'direcciones_page.dart';
import 'mapas_page.dart';




class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // quitar sombra
        title: Center(child: Text('Historial')), // false dentro de metodo
         actions: [
          IconButton(
            icon: Icon( Icons.delete_forever ), 
            onPressed: (){
                  
              Provider.of<ScanListProvider>(context, listen: false) // listen false estamos dentro de un metodo simple
                 .borrarTodos();

            }
          )
        ], 
      ),
      //body: _HomePageBody(),
      body: _HomePageBody(), // body se va cambiar de manera condicional - simplemente tener un widget regresa un widget usando swetch condicinal  

      bottomNavigationBar: CustomNavigationBar(), // created on cistom widget 
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // posicionar  floatingActionButton - aprobarmas props 
   );
  }
}


class _HomePageBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) { // regresa un widget de manera condicional

    //instancia tipo de provider del singlton 
     final uiProvider = Provider.of<UiProvider>(context); // implementa notify
    
    // Cambiar para mostrar la pagina respectiva
    // ser centralizado provider singlton  manejable de alfgun logar ..
     final currentIndex = uiProvider.selectedMenuOpt;

    // Usar el ScanListProvider - cuando pase por este punto no quiero que se redibuje por eso listen en false
    // luego cando solicito data desde el mismo provider dentro de los widgets pages la dejo en true paraque va redibujando los cambios reltime
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);


    switch( currentIndex ) {  //aqui sabemos que apgina a mostrars

      case 0:
        scanListProvider.cargarScanPorTipo('geo'); // prepara data 
        return MapasPage();

      case 1: 
        scanListProvider.cargarScanPorTipo('http'); // prepara data
        return DireccionesPage();

      default:
        return MapasPage();
    }


  }
} // widget privado solo servira en este archivo 