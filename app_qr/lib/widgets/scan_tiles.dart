import 'package:app_qr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qr/providers/scan_list_provider.dart';
//import 'package:app_qr/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  
  final String tipo;

  const ScanTiles({ required this.tipo });


  @override
  Widget build(BuildContext context) {

     // obteenr data del provider asociado al UI - por defult true , escuchar cambios redibujar
     final scanListProvider = Provider.of<ScanListProvider>(context); 
     final scans = scanListProvider.scans;

       print(tipo);
       
      
       return ListView.builder(
         itemCount:scans.length,
         itemBuilder: (_, i) => Dismissible( // delete glisando 
           key: UniqueKey(), // borra de la pantalla , pero de la db tenemos que gacer nostros
           background: Container(
            color: Colors.red, 
           ), 
           onDismissed: (DismissDirection direction) { // podemos restringir direction - delete de db impactar db
               Provider.of<ScanListProvider>(context, listen: false)
                  .borrarScanPorId(scans[i].id!);
           },
           child: ListTile(
            // leading: Icon( Icons.home, color: Theme.of(context).primaryColor), // de esta manera sicamvia color primary se cambiara , from main global
             leading: Icon( 
                tipo == 'http'
                  ? Icons.home_outlined
                  : Icons.map, 
                color: Theme.of(context).primaryColor 
             ), 
             title: Text(  scans[i].valor ),
             subtitle: Text(  scans[i].id.toString()),
             trailing: Icon( Icons.keyboard_arrow_right, color: Colors.blue ), // indicar a user se peude hacer click en la opciones
             onTap: () => launchURL(context, scans[i]), // mando context para tema de navigacion 
           ),
         ),
         
     
       );
     
  }
}


/* 
final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder( // construir una lista
      itemCount:  scans.length,
      itemBuilder: ( _, i ) => Dismissible( // 165
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScanPorId(scans[i].id);
        },
        child: ListTile( // => lo que regreso
          leading: Icon( 
            tipo == 'http'
              ? Icons.home_outlined
              : Icons.map_outlined,  
            color: Theme.of(context).primaryColor //  de esta manera si colo primario cambiara lo leo del context y se acabo el asunto 
          ),
          title: Text( scans[i].valor ),
          subtitle: Text( scans[i].id.toString() ),
          trailing: Icon( Icons.keyboard_arrow_right, color: Colors.grey ),
          onTap: () => launchURL(context, scans[i]),
        ),
      )
    );
 */