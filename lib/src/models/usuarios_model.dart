// To parse this JSON data, do
//
//     final soportesModel = soportesModelFromJson(jsonString);

import 'dart:convert';

import 'package:cliente_app_v1/src/models/usuario_notificacion_model.dart';

UsuariosModel soportesModelFromJson(String str) =>
    UsuariosModel.fromJson(json.decode(str));

String soportesModelToJson(UsuariosModel data) => json.encode(data.toJson());

class UsuariosModel {
  UsuariosModel({
    this.id = '',
    //this.idUs = '',
    this.email = '',
    this.nombre = '',
    this.rol = '',
    this.token = '',
    //this.notificaciones,
  });

  String id;
  //String idUs;
  String email;
  String nombre;
  String rol;
  String token;
  // List<NotificationsModel> notificaciones;

  factory UsuariosModel.fromJson(Map<String, dynamic> json) => UsuariosModel(
        id: json["id"],
        //idUs: json["idUs"],
        email: json["email"],
        nombre: json["nombre"],
        rol: json["rol"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "email": email, "nombre": nombre, "rol": rol, "token": token};
}
