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

  @override
  Widget build(BuildContext context) {
    //User? user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/paw.png'),
                  fit: BoxFit.cover,
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
          ListTile(
              leading: Icon(
                Icons.assignment,
                color: Colors.green,
              ),
              title: Text('Llenar formulario de adopcion'),
              onTap: () {
                _auth.authStateChanges().listen((User? user) {
                  if (user == null) {
                    print('User is currently signed out!');
                  } else {
                    print('User is signed in!');
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
              }),
          ListTile(
            leading: Icon(Icons.fact_check, color: Colors.green),
            title: Text('Seguimiento'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'evidencia');
            },
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.green),
            title: Text('Regresar'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
        ],
      ),
    );
  }
}
