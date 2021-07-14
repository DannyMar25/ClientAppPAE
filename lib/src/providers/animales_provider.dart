import 'dart:convert';
import 'dart:io';

import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class AnimalesProvider {
  final String _url =
      'https://flutter-varios-1637a-default-rtdb.firebaseio.com';

  final _prefs = new PreferenciasUsuario();

  Future<List<AnimalModel>> cargarAnimal() async {
    //final url = '$_url/animales.json?auth=${_prefs.token}';
    final url = '$_url/animales.json';
    final resp = await http.get(Uri.parse(url));
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<AnimalModel> animales = <AnimalModel>[];

    //print(decodedData);

    if (decodedData == null) {
      return [];
    }

    decodedData.forEach((id, animal) {
      //print(prod);\
      final animalTemp = AnimalModel.fromJson(animal);
      animalTemp.id = id;

      animales.add(animalTemp);
    });

    print(animales);

    return animales;
  }
}
