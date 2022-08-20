import 'package:cliente_app_v1/src/bloc/login_bloc.dart';
import 'package:cliente_app_v1/src/bloc/provider.dart';
import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/usuarios_model.dart';
import 'package:cliente_app_v1/src/pages/forgotPassword_page.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/utils/constants.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  //const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioProvider = new UsuarioProvider();
  AnimalModel animal = new AnimalModel();

  @override
  Widget build(BuildContext context) {
    final Object? animData = ModalRoute.of(context)!.settings.arguments;
    if (animData != null) {
      animal = animData as AnimalModel;
      print(animal.id);
    }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Inicio'),
      //   backgroundColor: Colors.green,
      // ),
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 230.0, //230
            ),
          ),
          Container(
            // width: 390.0,
            width: 390.0,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.symmetric(vertical: 60.0), //80
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: [
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearBoton(bloc),
                Divider(
                  color: Colors.white,
                ),
                _crearBotonGoogle(context),
              ],
            ),
          ),
          _crearBotonPass(context),
          //Text('Olvido la contrasena?'),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, 'registro'),
            child: Text(
              'Crear una nueva cuenta',
              style: TextStyle(color: Colors.green, fontSize: 17),
            ),
          ),
          SizedBox(
            height: 100.0, //100
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.green),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              //counterText: snapshot.data,
              errorText:
                  snapshot.error != null ? snapshot.error.toString() : null,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            //keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.green),
              //hintText: 'ejemplo@correo.com',
              labelText: 'Contraseña',
              //counterText: snapshot.data,
              errorText:
                  snapshot.error != null ? snapshot.error.toString() : null,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    //formValidStream
    //snapshot.hasData
    //true ? algo asi si true: algo asi si false
    return StreamBuilder(
      stream: bloc.formValidStreamL,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 0.0,
              primary: Colors.green,
              textStyle: TextStyle(color: Colors.white)),
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  Future<String?> getFcm() async {
    late FirebaseMessaging messaging;
    messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();
    return token;
  }

  _login(LoginBloc bloc, BuildContext context) async {
    final prefs = new PreferenciasUsuario();
    Map info = await usuarioProvider.login(bloc.email, bloc.password);
    if (info['ok']) {
      final user = await usuarioProvider.obtenerUsuario(info['uid']);
      final tokenFcm = await getFcm();
      prefs.setUid(info['uid']);
      prefs.setEmail(bloc.email);
      prefs.setRol(user['rol']);
      usuarioProvider.saveFcmToken(info['uid'], tokenFcm!);
      Navigator.pushReplacementNamed(context, 'intro', arguments: animal);
    } else {
      //mostrarAlerta(context, info['mensaje']);
      mostrarAlerta(context,
          'El correo o contraseña son incorrectos. Si no tienes credenciales por favor créalas.');
    }

    //Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _crearBotonGoogle(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    return OutlinedButton(
      //splashColor: Colors.grey,
      onPressed: () async {
        final user = await usuarioProvider.signInGoogle();
        final comprobar = await usuarioProvider.comprobarUsuario(user!.uid);
        if (comprobar) {
          usuarioProvider.crearUsuario(UsuariosModel(
              email: user.email!,
              nombre: user.displayName!,
              id: user.uid,
              rol: Roles.cliente));
        }
        //anadido el 9 de agosto
        final user1 = await usuarioProvider.obtenerUsuario(user.uid);
        prefs.setUid(user.uid);
        prefs.setEmail(user.email!);
        prefs.setRol(user1['rol']);
        Navigator.pushReplacementNamed(context, 'intro');
      },
      style: OutlinedButton.styleFrom(
        primary: Colors.grey,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: Colors.grey, width: 1.0), // HERE
        ),
      ),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // highlightElevation: 0,
      // borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Ingresa con Google',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: 400.0,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color.fromARGB(255, 11, 211, 78),
          Color.fromARGB(255, 11, 180, 48),
        ]),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
    return Stack(
      children: [
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, left: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              //Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              Image.asset('assets/pet-care.png', height: 190),
              SizedBox(height: 10.0, width: double.infinity),
              // Text(
              //   'BIENVENID@',
              //   style: TextStyle(color: Colors.white, fontSize: 25.0),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _crearBotonPass(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          ForgotPassword.id,
        );
      },
      child: Text(
        '¿Olvidó la contraseña?',
        style: TextStyle(color: Colors.green, fontSize: 20),
      ),
    );
  }
}
