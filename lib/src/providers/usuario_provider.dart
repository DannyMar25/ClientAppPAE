import 'dart:convert';

import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyCKF3vYr8Kn-6RQTrhiqc1IcEp1bC8HfWU';
  final _prefs = new PreferenciasUsuario();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
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
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  //cerrar sesion
  void signOut() async {
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
}
