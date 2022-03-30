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
                  image: AssetImage('assets/menu-img.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.pages,
              color: Colors.blue,
            ),
            title: Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(
              Icons.meeting_room,
              color: Colors.blue,
            ),
            title: Text('Agendar cita'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'registroCita');
            },
          ),
          ListTile(
              leading: Icon(
                Icons.assignment,
                color: Colors.blue,
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
          // ListTile(
          //   leading: Icon(
          //     Icons.meeting_room,
          //     color: Colors.blue,
          //   ),
          //   title: Text('Subir archivos'),
          //   onTap: () {
          //     Navigator.pushReplacementNamed(context, 'demoArchivos');
          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.app_registration,
          //     color: Colors.blue,
          //   ),
          //   title: Text('Registro citas'),
          //   onTap: () =>
          //       Navigator.pushReplacementNamed(context, 'registroCita'),
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.app_registration,
          //     color: Colors.blue,
          //   ),
          //   title: Text('Registro cliente'),
          //   onTap: () => Navigator.pushReplacementNamed(context, 'regcliente'),
          // ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Seguimiento'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'evidencia');
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.app_registration,
          //     color: Colors.blue,
          //   ),
          //   title: Text('Ver ubicacion'),
          //   onTap: () =>
          //       Navigator.pushReplacementNamed(context, 'ubicacionMapC'),
          // ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
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
