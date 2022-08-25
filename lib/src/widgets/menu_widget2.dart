import 'package:flutter/material.dart';

class SubMenuWidget extends StatefulWidget {
  //const MenuWidget({Key? key}) : super(key: key);
  @override
  State<SubMenuWidget> createState() => _SubMenuWidgetState();
}

class _SubMenuWidgetState extends State<SubMenuWidget> {
  @override
  Widget build(BuildContext context) {
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
            title: Text('Seguimiento Home'),
            onTap: () => Navigator.pushNamed(context, 'seguimientoMain'),
          ),
          ListTile(
            leading: Icon(
              Icons.meeting_room,
              color: Colors.blue,
            ),
            title: Text('Registro Vacunas'),
            onTap: () {
              Navigator.pushNamed(context, 'registroVacunas');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.app_registration,
              color: Colors.blue,
            ),
            title: Text('Ver Registro vacunas'),
            onTap: () => Navigator.pushNamed(context, 'verRegistroVacunas'),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Registro Desparasitacion'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushNamed(context, 'registroDesp');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Ver Registro Desparasitacion'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushNamed(context, 'verRegistroDesp');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Cargar Evidencia'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushNamed(context, 'demoArchivos');
            },
          ),
        ],
      ),
    );
  }
}
