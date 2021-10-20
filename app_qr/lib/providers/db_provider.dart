
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';


import 'package:app_qr/models/scan_model.dart';
export 'package:app_qr/models/scan_model.dart'; 


// la idea de este dbprovider de informacion tener un singlton - paraque no importe yo instancie siempre voy a tomar la misma instancia crea de esta db 

class DBProvider { // ojo este provider no implementa change notifier - se importa en widget  y se utuliza directamente como singlton 


   static Database? _database; //donde mantener instancia de nuestra db 
   static final DBProvider db = DBProvider._(); // instancia de esa clase lista : as  DBProvider.Private_() constructor privado - sirva para crear un singlton 
 
   DBProvider._(); // nuestro constructor privado - ayuadme cuando instancio DBProvider siempre obtengo la misma instancia creada del mismo object 

   

  // para acceder al object _database - getter
   Future<Database> get database async {
     if ( _database != null ) return _database!; // si ya instancie antes quiero que regrese la misma instancia db 
 
     _database = await initDB(); // si la primera vez aun no tengo db - estable conexion crear structur table 
 
     return _database!;
 
   } 

   Future<Database> initDB() async{ // creacion de nuestra db 

    // es path donde vamos a tener db fisicamente en el espacio respectivo de nuestra app cuando se installe en dispotivo / emulador
    // cuando se borre la app se borre ese documentDirectory - se borre db tambien 
    Directory documentsDirectory = await getApplicationDocumentsDirectory(); // path se obtine atraves del paquete que hemos instalado path_provider 
    final path = join( documentsDirectory.path, 'ScansDB.db' ); // build url donde estara nuestra db 
    //print( path );

    // Crear base de datos
    return await openDatabase( // es del paquete desqlite
      path,
      version: 1, // cambios estructurales en db son versiones - borra table , edit , debe incrementar en en secuecia al respeto para hacer el combio estructural en db  
      onOpen: (db) { },
      onCreate: ( Database db, int version ) async {  // es todo que necesito para crear tabla db 
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        '''); // consejor borra db recrearla 158 min 10 
      }
    );
   
   } 


   Future<int> nuevoScanRaw( ScanModel nuevoScan ) async { // insertar en db 

    final id    = nuevoScan.id; // id se autogenera pero necesito insertarlo
    final tipo  = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Verificar la base de datos - espere hasta que este lista 
    final db = await database; // db variable local es de tipo Database 

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES( $id, '$tipo', '$valor' ) 
    ''');

    return res;
   }  // opcion 1 es mucho trabajo pero seria bien para entender proceso de rawInsert 

   Future<int> nuevoScan( ScanModel nuevoScan ) async {

    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson() ); // ventaja inserta todos campos modelo - rapid a escribir 
  
    //print(res);
    // res es lastId inserted ;
    return res;

   } // insersacion rapida equivale nuvoScanRow

   Future<ScanModel?> getScanById( int id ) async {

    final db  = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]); // db.query('Scans') => trea all - 160 para masa filtros 

     //print(res);
    return res.isNotEmpty
          ? ScanModel.fromJson( res.first ) // instancia del modelo cargada de db
          : null;
   }

   Future<List<ScanModel>> getTodosLosScans() async {

    final db  = await database;
    final res = await db.query('Scans');

    //print(res);
    return res.isNotEmpty
          ? res.map( (s) => ScanModel.fromJson(s) ).toList() // map es un meto tiene todo tipo list  - map regresa iterable lo coonvierto el lista 
          : [];
   }

   Future<List<ScanModel>> getScansPorTipo( String tipo ) async {

     final db  = await database;
     final res = await db.rawQuery('''
       SELECT * FROM Scans WHERE tipo = '$tipo'    
     ''');

  
     return res.isNotEmpty
           ? res.map( (s) => ScanModel.fromJson(s) ).toList()
           : [];
   }

   Future<int> updateScan( ScanModel nuevoScan ) async {
      final db  = await database;
      final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [ nuevoScan.id ] ); // mucho cuidado sin condicion actualizara toda tabla

      // id updated
      return res;
   }

   Future<int> deleteScan( int id ) async {
    final db  = await database;
    final res = await db.delete( 'Scans', where: 'id = ?', whereArgs: [id] );
    
    //print(res);
    return res;
   }

   Future<int> deleteAllScans() async {
    final db  = await database;
    final res = await db.rawDelete('''




      DELETE FROM Scans    
    ''');
    
    // laist id deleted , after delete all will id is 0
    return res;
   }




   
  


 

} // en en este metodo tendremos metodos predeterminada para hacer cualquier interaccion con db
  // incluyen metodos de segurida para evitar injecciones sql 
  // metodos asociados a interectuar con db 

