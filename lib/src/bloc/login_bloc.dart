import 'dart:async';

//import 'package:flutter/foundation.dart';
import 'package:cliente_app_v1/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _usNameController = BehaviorSubject<String>();
  //nuevo
  final _passwordConfirmController = BehaviorSubject<String>();

  //_emailController.value

  //Recuperar los datos del stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<String> get nameStream =>
      _usNameController.stream.transform(validarNombre);

  //nuevo

  Stream<String> get passwordConfirmStream => _passwordConfirmController.stream
          .transform(validarPassword)
          .doOnData((String? c) {
        if (0 != _passwordController.value.compareTo(c!)) {
          _passwordConfirmController.addError("Contraseñas no coinciden.");
        }
      });

  Stream<bool> get formValidStream => Rx.combineLatest3(
      emailStream, passwordStream, nameStream, (e, p, n) => true);
  Stream<bool> get formValidStreamL =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Stream<bool> get formValidStream1 => Rx.combineLatest4(emailStream,
      passwordStream, nameStream, passwordConfirmStream, (e, p, n, s) => true);

  //Insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _usNameController.sink.add;
  Function(String) get changePasswordConfirm =>
      _passwordConfirmController.sink.add;

  //Obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get name => _usNameController.value;
  String get passwordConfirm => _passwordController.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
    _usNameController.close();
    _passwordConfirmController.close();
  }
}
