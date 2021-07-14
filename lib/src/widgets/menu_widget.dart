import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

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
            title: Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(
              Icons.meeting_room,
              color: Colors.blue,
            ),
            title: Text('Agendar cita'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.assignment,
              color: Colors.blue,
            ),
            title: Text('Llenar formulario de adopcion'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.app_registration,
              color: Colors.blue,
            ),
            title: Text('Registro cliente'),
            onTap: () => Navigator.pushReplacementNamed(context, 'regcliente'),
          ),
          ListTile(
            leading: Icon(
              Icons.app_registration,
              color: Colors.blue,
            ),
            title: Text('Ver ubicacion'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'ubicacionMapC'),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Regresar'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'bienvenida');
            },
          ),
        ],
      ),
    );
  }
}
