
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:app_qr/providers/scan_list_provider.dart';
import 'package:app_qr/utils/utils.dart';

class ScanButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0, // out sombra
      child: Icon( Icons.filter_center_focus ),
      onPressed: () async {
        
         // color rayta , mensaje button ,flash light , leer codigo qr
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#E80751', 'close', false, ScanMode.QR );
         
         // TODO cuando no uso despositivo fisico termino con data fectisia para acabar el desarolo de la app 
         // final barcodeScanRes = 'geo:24.469602, 54.348842';
         //';'  final barcodeScanRes = 'https://instagram.com';
        
            print(barcodeScanRes); // lo que viene en respuesta

         if ( barcodeScanRes == '-1' ) {
           return;
         }

        // para hacer insercion - estoy dentro de un metodo no builder method esto no necesita que se redibujo daria err - listen false 
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false); 
        
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes); 

        launchURL(context, nuevoScan);
      }
    );
  }
}