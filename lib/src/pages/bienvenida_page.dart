import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class BienvenidaPage extends StatelessWidget {
  //const HomePage({Key? key}) : super(key: key);

  //static final String routeName = 'home';
  final prefs = new PreferenciasUsuario();
  final usuarioProvider = new UsuarioProvider();
  TextEditingController _newpass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //prefs.ultimaPagina = HomePage.routeName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias de usuario'),
        //backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Column(
        children: [
          Center(
            child: Text('BIENVENID@'),
          ),
          TextFormField(
            //initialValue: animal.nombre,
            controller: _newpass,
            readOnly: false,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'cambiar contrasena',
            ),
            onTap: () {
              usuarioProvider.changePassword(_newpass.text);
            },
          )
        ],
      ),
    );
  }
}
