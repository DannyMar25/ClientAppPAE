import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
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
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushNamed(context, 'intro');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.pets,
              color: Colors.green,
            ),
            title: Text('Ver mascotas'),
            onTap: () => Navigator.pushNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(
              Icons.edit_calendar,
              color: Colors.green,
            ),
            title: Text('Agendar cita'),
            onTap: () {
              Navigator.pushNamed(context, 'registroCita');
            },
          ),
          email != ''
              ? ListTile(
                  leading: Icon(
                    Icons.assignment,
                    color: Colors.green,
                  ),
                  title: Text('Adopción'),
                  onTap: () {
                    mostrarAlertaOk(
                        context,
                        'Para poder llenar el formulario de adopción debes seleccionar a tu futura mascota en nuestra galería.',
                        'home',
                        '¡Atención!',
                        'Ver mascotas');
                    //Navigator.pushReplacementNamed(context, 'home');
                  })
              : SizedBox(),
          email != ''
              ? ListTile(
                  leading: Icon(Icons.fact_check, color: Colors.green),
                  title: Text('Seguimiento'),
                  onTap: () {
                    //Navigator.pop(context);
                    Navigator.pushNamed(context, 'evidencia');
                  },
                )
              : SizedBox(),
          Padding(padding: EdgeInsets.only(top: 350.0)),
          Text(
            '2022 Versión: 0.0.1',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
