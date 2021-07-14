import 'package:cliente_app_v1/src/bloc/provider.dart';
import 'package:cliente_app_v1/src/pages/animal_page.dart';
import 'package:cliente_app_v1/src/pages/bienvenida_page.dart';
import 'package:cliente_app_v1/src/pages/home_page.dart';
import 'package:cliente_app_v1/src/pages/login_page.dart';
import 'package:cliente_app_v1/src/pages/registro_cliente.dart';
import 'package:cliente_app_v1/src/pages/registro_page.dart';
import 'package:cliente_app_v1/src/pages/ubicacion_cliente_page.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);

    return Provider(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'login',
          routes: {
            'login': (_) => LoginPage(),
            'registro': (_) => RegistroPage(),
            'home': (_) => HomePage(),
            'animal': (_) => AnimalPage(),
            'bienvenida': (_) => BienvenidaPage(),
            'regcliente': (_) => RegistroClientePage(),
            'ubicacionMapC': (_) => UbicacionPage()
          },
          theme: ThemeData(primaryColor: Colors.deepPurple)),
    );
  }
}
