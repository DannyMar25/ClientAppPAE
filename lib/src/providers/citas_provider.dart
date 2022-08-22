import 'package:cliente_app_v1/src/models/citas_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CitasProvider {
  CollectionReference refCit = FirebaseFirestore.instance.collection('citas');
  Future<bool> crearCita(
    CitasModel cita,
  ) async {
    try {
      // print("este esadkjljdkjadkjskadjlkjsdljasdljasdj");
      var citasAdd = await refCit.add(cita.toJson());
      await refCit.doc(citasAdd.id).update({"id": citasAdd.id});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> comprobarDatosCita(String correo) async {
    try {
      await refCit
          .where('correoClient', isEqualTo: correo)
          .where('estado', isEqualTo: 'Pendiente')
          .get();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Future<CitasModel>>> verificar(String correo) async {
    var documents = await refCit
        .where('estado', isEqualTo: 'Pendiente')
        .where('correoClient', isEqualTo: correo)
        .get();
    //citas.addAll
    var s = (documents.docs.map((e) async {
      var data = e.data() as Map<String, dynamic>;
      var cita = CitasModel.fromJson({
        "id": e.id,
        "nombreClient": e["nombreClient"],
        "telfClient": e["telfClient"],
        "correoClient": e["correoClient"],
        "estado": e["estado"],
        "fechaCita": e["fechaCita"],
        "idAnimal": e["idAnimal"],
        "idHorario": e["idHorario"]
      });
      return cita;
    }));
    return s.toList();
  }
}
