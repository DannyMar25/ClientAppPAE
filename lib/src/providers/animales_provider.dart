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
    var documents =
        await refAn.where('nombre', isNotEqualTo: 'Sin Definir').get();
    animales.addAll(documents.docs.map((e) {
      //var animal = AnimalModel.fromJson(e.data() as Map<String, dynamic>);
      var data = e.data() as Map<String, dynamic>;
      var animal = AnimalModel.fromJson({
        "id": e.id,
        "especie": data["especie"],
        "nombre": data["nombre"],
        "sexo": data["sexo"],
        "etapaVida": data["etapaVida"],
        "temperamento": data["temperamento"],
        "peso": data["peso"],
        "tamanio": data["tamanio"],
        "color": data["color"],
        "raza": data["raza"],
        "esterilizado": data["esterilizado"],
        "estado": data["estado"],
        "caracteristicas": data["caracteristicas"],
        "fotoUrl": data["fotoUrl"]
      });
      return animal;
    }).toList());
    return animales;
  }

  Future<AnimalModel> cargarAnimalId(String id) async {
    AnimalModel animals = new AnimalModel();
    final doc = await refAn.doc(id).get();
    var data = doc.data() as Map<String, dynamic>;

    animals = AnimalModel.fromJson({
      "id": doc.id,
      "especie": data["especie"],
      "nombre": data["nombre"],
      "sexo": data["sexo"],
      "etapaVida": data["etapaVida"],
      "temperamento": data["temperamento"],
      "peso": data["peso"],
      "tamanio": data["tamanio"],
      "color": data["color"],
      "raza": data["raza"],
      "esterilizado": data["esterilizado"],
      "estado": data["estado"],
      "caracteristicas": data["caracteristicas"],
      "fotoUrl": data["fotoUrl"]
    });

    return animals;
  }

  //Future<List<Future<AnimalModel>>> cargarBusqueda(
  Future<List<AnimalModel>> cargarBusqueda(
      String especie, String sexo, String etapaVida, String tamanio) async {
    final List<AnimalModel> animales = <AnimalModel>[];
    var documents = await refAn
        .where('especie', isEqualTo: especie)
        .where('sexo', isEqualTo: sexo)
        .where('etapaVida', isEqualTo: etapaVida)
        .where('tamanio', isEqualTo: tamanio)
        .get();
    //var s = (documents.docs.map((e) async {
    animales.addAll(documents.docs.map((e) {
      //var animal = AnimalModel.fromJson(e.data() as Map<String, dynamic>);
      var data = e.data() as Map<String, dynamic>;
      var animal = AnimalModel.fromJson({
        "id": e.id,
        "especie": data["especie"],
        "nombre": data["nombre"],
        "sexo": data["sexo"],
        "etapaVida": data["etapaVida"],
        "temperamento": data["temperamento"],
        "peso": data["peso"],
        "tamanio": data["tamanio"],
        "color": data["color"],
        "raza": data["raza"],
        "esterilizado": data["esterilizado"],
        "estado": data["estado"],
        "caracteristicas": data["caracteristicas"],
        "fotoUrl": data["fotoUrl"]
      });
      return animal;
    }).toList());
    //return s.toList();
    return animales;
  }

  Future<bool> editarEstado(AnimalModel animal, String estado) async {
    try {
      await refAn.doc(animal.id).update({"estado": estado});
      return true;
    } catch (e) {
      return false;
    }
  }
}
