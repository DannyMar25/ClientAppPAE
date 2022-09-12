import 'package:cliente_app_v1/src/bloc/provider.dart';
import 'package:cliente_app_v1/src/pages/animal_page.dart';
import 'package:cliente_app_v1/src/pages/bienvenida_page.dart';
import 'package:cliente_app_v1/src/pages/busqueda_page.dart';
import 'package:cliente_app_v1/src/pages/evidencias_page.dart';
import 'package:cliente_app_v1/src/pages/forgotPassword_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_parte1_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_parte2_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_parte3_page.dart';
import 'package:cliente_app_v1/src/pages/formulario_parte4_page.dart';
import 'package:cliente_app_v1/src/pages/galeriaMascotas_page.dart';
import 'package:cliente_app_v1/src/pages/intro_page.dart';
import 'package:cliente_app_v1/src/pages/login_page.dart';
import 'package:cliente_app_v1/src/pages/notificaciones_page.dart';
import 'package:cliente_app_v1/src/pages/perfilMascotaMain_page.dart';
import 'package:cliente_app_v1/src/pages/perfilMascota_pdf_page.dart';
import 'package:cliente_app_v1/src/pages/registro_cita.dart';
import 'package:cliente_app_v1/src/pages/registro_cliente.dart';
import 'package:cliente_app_v1/src/pages/registro_desp_page.dart';
import 'package:cliente_app_v1/src/pages/registro_page.dart';
import 'package:cliente_app_v1/src/pages/registro_vacunas_page.dart';
import 'package:cliente_app_v1/src/pages/resultados_busqueda_page.dart';
import 'package:cliente_app_v1/src/pages/seguimiento_page.dart';
import 'package:cliente_app_v1/src/pages/subir_archivos.dart';
import 'package:cliente_app_v1/src/pages/ubicacion_cliente_page.dart';
import 'package:cliente_app_v1/src/pages/ver_registro_desp_page.dart';
import 'package:cliente_app_v1/src/pages/ver_registro_vacunas_page.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  print("icon: ${message.notification!.android!.smallIcon}");
  print("data string ${message.data.toString()}");
  print("data ${message.data}");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);
    final email = prefs.email;

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
          //initialRoute: 'formularioP3',
          initialRoute: 'intro',
          //initialRoute: 'perfilMascota',
          routes: {
            'login': (_) => LoginPage(),
            'registro': (_) => RegistroPage(),
            'home': (_) => GaleriaMascotasPage(),
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
            'intro': (_) => IntroPage(),
            'busqueda': (_) => BusquedaPage(),
            'resultadoBusqueda': (_) => ResultadosBusquedaPage(),
            ForgotPassword.id: (context) => ForgotPassword(),
            'perfilMascota': (_) => PerfilMainPage(),
            'perfilMascotaPdf': (_) => CrearPerfilMascotaPdfPage(),
            'notificaciones': (_) => NotificacionesScreen()
          },
          theme: ThemeData(primaryColor: Colors.deepPurple)),
    );
  }
}
