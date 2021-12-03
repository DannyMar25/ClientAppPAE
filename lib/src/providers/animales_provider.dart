//import 'dart:convert';
//import 'dart:io';

import 'package:cliente_app_v1/src/models/animales_model.dart';
//import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:http/http.dart' as http;

class AnimalesProvider {
  CollectionReference refAn = FirebaseFirestore.instance.collection('animales');
  //late AnimalModel animal1;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<AnimalModel>> cargarAnimal() async {
    final List<AnimalModel> animales = <AnimalModel>[];
    var documents = await refAn.get();
    animales.addAll(documents.docs.map((e) {
      //var animal = AnimalModel.fromJson(e.data() as Map<String, dynamic>);
      var data = e.data() as Map<String, dynamic>;
      var animal = AnimalModel.fromJson({
        "id": e.id,
        "nombre": data["nombre"],
        "sexo": data["sexo"],
        "edad": data["edad"],
        "temperamento": data["temperamento"],
        "peso": data["peso"],
        "tamanio": data["tamanio"],
        "color": data["color"],
        "raza": data["raza"],
        "caracteristicas": data["caracteristicas"],
        "fotoUrl": data["fotoUrl"]
      });
      return animal;
    }).toList());
    return animales;
  }
}
