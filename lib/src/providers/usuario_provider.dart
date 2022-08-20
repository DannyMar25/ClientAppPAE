import 'dart:async';
import 'dart:convert';

import 'package:cliente_app_v1/src/models/usuarios_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyCKF3vYr8Kn-6RQTrhiqc1IcEp1bC8HfWU';
  final _prefs = new PreferenciasUsuario();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  CollectionReference refUser =
      FirebaseFirestore.instance.collection('usuarios');

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    //print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];

      return {
        'ok': true,
        'token': decodedResp['idToken'],
        'uid': decodedResp['localId']
      };
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password, String name) async {
    final authData = {
      'email': email,
      'password': password,
      'displayName': name,
      'returnSecureToken': true
    };

    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    //print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {
        'ok': true,
        'token': decodedResp['idToken'],
        'uid': decodedResp['localId']
      };
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  //cerrar sesion
  void signOut() async {
    _prefs.removeEmail();
    await _auth.signOut();
    await _googleSignIn.signOut();
    return;
  }

  //Iniciar sesion con google
  User? get user {
    return _auth.currentUser;
  }

  Future<User?> signInGoogle() async {
    try {
      final GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      print(user);

      if (user!.uid == _auth.currentUser!.uid) return user;
    } catch (e) {
      print('Error in signInGoogle Method: ${e.toString()}');
    }
    return null;
  }

  Future<Null> changePassword(String newPassword) async {
    final String changePasswordUrl =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo?key=$_firebaseToken';

    final String idToken =
        await user!.getIdToken(); // where user is FirebaseUser user

    final Map<String, dynamic> payload = {
      'email': idToken,
      'password': newPassword,
      'returnSecureToken': true
    };

    await http.post(
      Uri.parse(changePasswordUrl),
      body: json.encode(payload),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<bool> crearUsuario(
    UsuariosModel usuario,
  ) async {
    try {
      // print("este esadkjljdkjadkjskadjlkjsdljasdljasdj");
      await refUser.doc(usuario.id).set(usuario.toJson());
      //await refUser.doc(usuariosAdd.id).update({"idUs": usuariosAdd.id});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> comprobarUsuario(String uid) async {
    try {
      // print("este esadkjljdkjadkjskadjlkjsdljasdljasdj");
      final user = await refUser.doc(uid).get();
      // print(user.data());
      //print(user.id);
      if (user.data() == null) {
        return true;
      } else {
        return false;
      }
      //await refUser.doc(usuariosAdd.id).update({"idUs": usuariosAdd.id});
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> obtenerUsuario(String uid) async {
    try {
      // print("este esadkjljdkjadkjskadjlkjsdljasdljasdj");
      final user = await refUser.doc(uid).get();
      // print(user.data());
      //print(user.id);
      // if (user.data() == null) {
      //   return true;
      // } else {
      //   return false;
      // }
      return user.data() as dynamic;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> saveFcmToken(String uid, String token) async {
    try {
      await refUser.doc(uid).update({'token': token});
      return true;
    } catch (e) {
      return false;
    }
  }
}
