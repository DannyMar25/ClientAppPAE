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
}
