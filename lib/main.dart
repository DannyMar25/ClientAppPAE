import 'package:cliente_app_v1/src/bloc/provider.dart';
import 'package:cliente_app_v1/src/pages/animal_page.dart';
import 'package:cliente_app_v1/src/pages/bienvenida_page.dart';
import 'package:cliente_app_v1/src/pages/evidencias_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_parte1_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_parte2_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_parte3_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_parte4_page.dart';
import 'package:cliente_app_v1/src/pages/home_page.dart';
import 'package:cliente_app_v1/src/pages/login_page.dart';
import 'package:cliente_app_v1/src/pages/registro_cita.dart';
import 'package:cliente_app_v1/src/pages/registro_cliente.dart';
import 'package:cliente_app_v1/src/pages/registro_desp_page.dart';
import 'package:cliente_app_v1/src/pages/registro_page.dart';
import 'package:cliente_app_v1/src/pages/registro_vacunas_page.dart';
import 'package:cliente_app_v1/src/pages/seguimiento_page.dart';
import 'package:cliente_app_v1/src/pages/subir_archivos.dart';
import 'package:cliente_app_v1/src/pages/ubicacion_cliente_page.dart';
import 'package:cliente_app_v1/src/pages/ver_registro_desp_page.dart';
import 'package:cliente_app_v1/src/pages/ver_registro_vacunas_page.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', 'US'), // English, no country code
            Locale('es', 'ES'), // Spanish, no country code
          ],
          initialRoute: 'home',
          routes: {
            'login': (_) => LoginPage(),
            'registro': (_) => RegistroPage(),
            'home': (_) => HomePage(),
            'animal': (_) => AnimalPage(),
            'bienvenida': (_) => BienvenidaPage(),
            'regcliente': (_) => RegistroClientePage(),
            'ubicacionMapC': (_) => UbicacionPage(),
            'registroCita': (_) => RegistroClienteCitas(),
            'formularioMain': (_) => FormularioAdopcionPage(),
            'formularioP1': (_) => FormDatPersonalesPage(),
            'formularioP2': (_) => FormSituacionFamPage(),
            'formularioP3': (_) => FormDomicilioPage(),
            'formularioP4': (_) => FormRelacionMascotas1Page(),
            'seguimientoMain': (_) => SeguimientoPage(),
            'registroVacunas': (_) => RegistroVacunasPage(),
            'verRegistroVacunas': (_) => VerRegistroVacunasPage(),
            'registroDesp': (_) => RegistroDespPage(),
            'verRegistroDesp': (_) => VerRegistroDespPage(),
            'demoArchivos': (_) => SubirArchivosPage(),
            'evidencia': (_) => EvidenciasPage(),
          },
          theme: ThemeData(primaryColor: Colors.deepPurple)),
    );
  }
}
