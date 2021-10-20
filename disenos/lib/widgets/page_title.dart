import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SafeArea( // pantalla iphone evitar escritura debajo de ..
      bottom: false,
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 20 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ // elementos debajo de otros
            Text('Classify transaction', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white )),
            SizedBox( height: 10 ), // separacion 
            Text('Classify this transaction into a particular category', style: TextStyle( fontSize: 16, color: Colors.white )),
          ],
        ),
      ),
    );
  }
}