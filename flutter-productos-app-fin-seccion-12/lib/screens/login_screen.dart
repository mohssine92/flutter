import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground( // my custom widget - recibe prop child - fondo screen , 
        child: SingleChildScrollView( // permite hacer scroll si sus hijos pasan tamano que tiene el dispositivo 
          child: Column(
            children: [

              SizedBox( height: 250 ), // fin que mis widgets van apareciendo un poco abajo

              CardContainer( // custom widget
                child: Column(
                  children: [

                    SizedBox( height: 10 ),
                    Text('Login', style: Theme.of(context).textTheme.headline4 ),
                    SizedBox( height: 30 ),
                    
                    ChangeNotifierProvider( // similar a multiprovider ,pero valido solo cando tenemos uno 
                      create: ( _ ) => LoginFormProvider(), //este provider solo le imporat al _loginForm 
                      child: _LoginForm() // formulario
                    )
                    

                  ],
                )
              ),

              SizedBox( height: 50 ),
              Text('Crear una nueva cuenta', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
              SizedBox( height: 50 ),
               
               // cando sale teclado tenemos espacio isuficiente alli hacemos scroll
            ],
          ),
        )
      )
   );
  }
}


class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context); // buscar instancia provider

    return Container( // siempre container si por si acaso quiero luego estilizar
      child: Form( // form widget va tener referencia al estado completo que tiene sus widgets internos 
        key: loginForm.formKey, // key del form nos va decir si el form y todos sus campos pasaron la validacion respectivas o no 
        autovalidateMode: AutovalidateMode.onUserInteraction, // dispara validator , hay varios escenarios para disparar el mismo 

        child: Column(  // uno bajo de otro 
          children: [
            
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration( // ui - custom class prop static , recibe estos props 
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electr??nico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: ( value ) => loginForm.email = value,
              validator: ( value ) { // validacion respectiva

                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null // conciderado la validacion paso 
                    : 'El valor ingresado no luce como un correo';

              },
            ),

            SizedBox( height: 30 ),

            TextFormField(
              autocorrect: false,
              obscureText: true, // invisible eclas password
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contrase??a',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: ( value ) => loginForm.password = value,
              validator: ( value ) { // validacion respectiva al momento de escribir

                  return ( value != null && value.length >= 6 ) 
                    ? null
                    : 'La contrase??a debe de ser de 6 caracteres';                                    
                  
              },
            ),

            SizedBox( height: 30 ),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading 
                    ? 'Espere'
                    : 'Ingresar',
                  style: TextStyle( color: Colors.white ),
                )
              ),
              onPressed: loginForm.isLoading ? null : () async { // para desahabilatr button onPress tiene que ser nul 
                
                FocusScope.of(context).unfocus(); // quitar teclado 
                
                if( !loginForm.isValidForm() ) return; // forezar validacion al dar click boton

                loginForm.isLoading = true; // ster - notifu - redibuja

                await Future.delayed(Duration(seconds: 2 ));

                // TODO: validar si el login es correcto occupar un backend
                loginForm.isLoading = false;

                Navigator.pushReplacementNamed(context, 'home'); // va destruir stack de pantallas y va dejar nueva pantalla aqui ya no puedo regresar
              }
            )

          ],
        ),
      ),
    );
  }
}