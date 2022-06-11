import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  //const MenuWidget({Key? key}) : super(key: key);
  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //late User currentuser;
  // bool isloggedin = false;
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    //User? user = FirebaseAuth.instance.currentUser;
    final email = prefs.email;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pet-care.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(
              Icons.meeting_room,
              color: Colors.green,
            ),
            title: Text('Agendar cita'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'registroCita');
            },
          ),
          email != ''
              ? ListTile(
                  leading: Icon(
                    Icons.assignment,
                    color: Colors.green,
                  ),
                  title: Text('Llenar formulario de adopcion'),
                  onTap: () {
                    _auth.authStateChanges().listen((User? user) {
                      if (user == null) {
                        print('User is currently signed out!');
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        print('User is signed in!');
                        Navigator.pushReplacementNamed(
                            context, 'formularioMain');
                      }
                    });
                    // if (user != null) {
                    //   Navigator.pushReplacementNamed(context, 'formularioMain');
                    // } else {
                    //   mostrarAlertaOkCancel(
                    //       context,
                    //       'Para poder ingresar al formulario, debe registrarse o iniciar sesion.',
                    //       'login');
                    // }

                    // mostrarAlertaOkCancel(
                    //     context,
                    //     'Para poder ingresar al formulario, debe registrarse o iniciar sesion.',
                    //     'login');
                  })
              : SizedBox(),
          ListTile(
            leading: Icon(Icons.fact_check, color: Colors.green),
            title: Text('Seguimiento'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'evidencia');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'bienvenida');
            },
          ),
        ],
      ),
    );
  }
}
