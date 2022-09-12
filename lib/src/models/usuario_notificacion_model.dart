import 'dart:convert';

UsuariosNotificacionesModel soportesModelFromJson(String str) =>
    UsuariosNotificacionesModel.fromJson(json.decode(str));

String soportesModelToJson(UsuariosNotificacionesModel data) =>
    json.encode(data.toJson());

class UsuariosNotificacionesModel {
  UsuariosNotificacionesModel({
    this.id = '',
    this.email = '',
    this.nombre = '',
    this.rol = '',

    //Esto puso yeye
  });

  String id;
  //String idUs;
  String email;
  String nombre;
  String rol;
  //String body;
  //String title;

  factory UsuariosNotificacionesModel.fromJson(Map<String, dynamic> json) =>
      UsuariosNotificacionesModel(
        id: json["id"],
        //idUs: json["idUs"],
        email: json["email"],
        nombre: json["nombre"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nombre": nombre,
        "rol": rol,
      };
}
