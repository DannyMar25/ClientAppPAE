import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/evidencia_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_domicilio_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/formulario_relacionAnimal_model.dart';
import 'package:cliente_app_v1/src/models/formulario_situacionFam_model.dart';
import 'package:cliente_app_v1/src/models/registro_desparaitaciones_model.dart';
import 'package:cliente_app_v1/src/models/registro_vacunas_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FormulariosProvider {
  CollectionReference refForm =
      FirebaseFirestore.instance.collection('formularios');

  final animalesProvider = new AnimalesProvider();
  //final formulariosProvider = new FormulariosProvider();
  FormulariosModel formulario = new FormulariosModel();

  //late AnimalModel animal1;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> crearFormularioPrin(
      FormulariosModel formulario,
      DatosPersonalesModel datosPersona,
      BuildContext context,
      var idAnimal) async {
    try {
      var formularioAdd = await refForm.add(formulario.toJson());
      await refForm.doc(formularioAdd.id).update({"id": formularioAdd.id});
      CollectionReference refFormDP = FirebaseFirestore.instance
          .collection('formularios')
          .doc(formularioAdd.id)
          .collection('datosPersonales');
      var datosPersonalesAdd = await refFormDP.add(datosPersona.toJson());
      await refFormDP
          .doc(datosPersonalesAdd.id)
          .update({"id": datosPersonalesAdd.id});

      await refForm
          .doc(formularioAdd.id)
          .update({"idDatosPersonales": datosPersonalesAdd.id});
      //return formularioAdd.id;
      var idFormu = formularioAdd.id;
      // Navigator.pushNamed(context, 'formularioP2',
      //     arguments: {'idFormu': idFormu, 'idAnimal': idAnimal});
      Navigator.pushReplacementNamed(context, 'formularioP2',
          arguments: {'idFormu': idFormu, 'idAnimal': idAnimal});
      print(idFormu);
      return idFormu;
    } catch (e) {
      return "";
    }
  }

  Future<bool> crearFormularioPrin1(
      FormulariosModel formulario, DatosPersonalesModel datosPersona) async {
    try {
      var formularioAdd = await refForm.add(formulario.toJson());
      await refForm.doc(formularioAdd.id).update({"id": formularioAdd.id});
      CollectionReference refFormDP = FirebaseFirestore.instance
          .collection('formularios')
          .doc(formularioAdd.id)
          .collection('datosPersonales');
      var datosPersonalesAdd = await refFormDP.add(datosPersona.toJson());
      await refFormDP
          .doc(datosPersonalesAdd.id)
          .update({"id": datosPersonalesAdd.id});

      await refForm
          .doc(formularioAdd.id)
          .update({"idDatosPersonales": datosPersonalesAdd.id});
      //return formularioAdd.id;

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> crearFormSituacionFam(SitFamiliarModel sitFamilia, var idFormu,
      BuildContext context, var idAnimal) async {
    CollectionReference refFormSF = FirebaseFirestore.instance
        .collection('formularios')
        .doc(idFormu)
        .collection('situacionFamiliar');
    try {
      var sitFamiliarAdd = await refFormSF.add(sitFamilia.toJson());
      await refFormSF.doc(sitFamiliarAdd.id).update({"id": sitFamiliarAdd.id});

      await refForm.doc(idFormu).update({"idSituacionFam": sitFamiliarAdd.id});
      var idFormu1 = idFormu;
      Navigator.pushReplacementNamed(context, 'formularioP3',
          arguments: {'idFormu': idFormu1, 'idAnimal': idAnimal});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> crearFormDomicilio(DomicilioModel domicilio, var idFormu1,
      BuildContext context, var idAnimal) async {
    CollectionReference refFormDom = FirebaseFirestore.instance
        .collection('formularios')
        .doc(idFormu1)
        .collection('domicilio');
    try {
      var domicilioAdd = await refFormDom.add(domicilio.toJson());
      await refFormDom.doc(domicilioAdd.id).update({"id": domicilioAdd.id});
      await refForm.doc(idFormu1).update({"idDomicilio": domicilioAdd.id});
      var idFormu2 = idFormu1;
      Navigator.pushReplacementNamed(context, 'formularioP4',
          arguments: {'idFormu': idFormu2, 'idAnimal': idAnimal});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> crearFormRelacionAnim(RelacionAnimalesModel relacionA,
      var idFormu2, BuildContext context, AnimalModel animal) async {
    CollectionReference refFormRel = FirebaseFirestore.instance
        .collection('formularios')
        .doc(idFormu2)
        .collection('relacionAnimal');
    try {
      var relacionAnimAdd = await refFormRel.add(relacionA.toJson());
      await refFormRel
          .doc(relacionAnimAdd.id)
          .update({"id": relacionAnimAdd.id});
      await refForm.doc(idFormu2).update({"idRelacionAn": relacionAnimAdd.id});
      mostrarOkFormulario(
          context,
          'La información ha sido guardada correctamente. La respuesta a tu solicitud llegará a tu correo electrónico dentro de 24 a 48 horas. \n\nPor favor revisa la bandeja de correo no deseado o spam.',
          'perfilMascota',
          idFormu2,
          animal);
      //Navigator.pushNamed(context, 'home');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Future<FormulariosModel>>> cargarInfo(
      String identificacion) async {
    var documents =
        await refForm.where('identificacion', isEqualTo: identificacion).get();
    var s = (documents.docs.map((e) async {
      AnimalModel anim = new AnimalModel();
      anim = await animalesProvider.cargarAnimalId(e["idAnimal"]);
      var formulario = FormulariosModel.fromJson({
        "id": e.id,
        "idAnimal": e["idAnimal"],
        "fechaIngreso": e["fechaIngreso"],
        "fechaRespuesta": e["fechaRespuesta"],
        "idClient": e["idClient"],
        "nombreClient": e["nombreClient"],
        "identificacion": e["identificacion"],
        "emailClient": e["emailClient"],
        "estado": e["estado"],
        "observacion": e["observacion"],
        "idDatosPersonales": e["idDatosPersonales"],
        "idSituacionFam": e["idSituacionFam"],
        "idDomicilio": e["idDomicilio"],
        "idRelacionAn": e["idRelacionAn"],
        "idVacuna": e["idVacuna"],
        "idDesparasitacion": e["idDesparasitacion"],
        "idEvidencia": e["idEvidencia"],
      });
      //cita.horario = h1;
      formulario.animal = anim;
      return formulario;
    }));
    return s.toList();
  }

  Future<DatosPersonalesModel> cargarDPId(String idf, String idD) async {
    DatosPersonalesModel datos = new DatosPersonalesModel();
    final doc =
        await refForm.doc(idf).collection('datosPersonales').doc(idD).get();
    var data = doc.data() as Map<String, dynamic>;

    datos = DatosPersonalesModel.fromJson({
      "id": data["id"],
      "nombreCom": data["nombreCom"],
      "cedula": data["cedula"],
      "direccion": data["direccion"],
      "fechaNacimiento": data["fechaNacimiento"],
      "ocupacion": data["ocupacion"],
      "email": data["email"],
      "nivelInst": data["nivelInst"],
      "telfCel": data["telfCel"],
      "telfDomi": data["telfDomi"],
      "telfTrab": data["telfTrab"],
      "nombreRef": data["nombreRef"],
      "parentescoRef": data["parentescoRef"],
      "telfRef": data["telfRef"],
    });

    return datos;
  }

  Future<bool> crearRegistroVacuna(
      RegistroVacunasModel vacuna, var idFormu, BuildContext context) async {
    CollectionReference refRegVac = FirebaseFirestore.instance
        .collection('formularios')
        .doc(idFormu)
        .collection('registroVacunas');
    CollectionReference refRegVacRoot =
        FirebaseFirestore.instance.collection('registroVacunas');
    final prefs = new PreferenciasUsuario();
    try {
      var vacunaAdd = await refRegVac.add(vacuna.toJson());
      await refRegVac.doc(vacunaAdd.id).update({"id": vacunaAdd.id});
      await refForm.doc(idFormu).update({"idVacuna": vacunaAdd.id});
      final uid = prefs.uid;
      final fechaProximaVacuna = vacuna.toJson()["fechaProximaVacuna"];
      print(fechaProximaVacuna);
      final dateFechaProx = DateTime.parse(fechaProximaVacuna);
      print(dateFechaProx);

      //await refRegVacRoot.doc(vacunaAdd.id).set(vacuna.toJson());
      await refRegVacRoot.doc(vacunaAdd.id).set({
        ...vacuna.toJson(),
        "fechaProximaVacuna": dateFechaProx,
      });

      await refRegVacRoot
          .doc(vacunaAdd.id)
          .update({"id": vacunaAdd.id, "idCliente": uid});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> crearRegistroDesparasitacion(
      RegistroDesparasitacionModel desparasitacion,
      var idFormu,
      BuildContext context) async {
    CollectionReference refRegDesp = FirebaseFirestore.instance
        .collection('formularios')
        .doc(idFormu)
        .collection('registroDesparasitacion');
    CollectionReference refRegDespRoot =
        FirebaseFirestore.instance.collection('registroDesparasitacion');
    final prefs = new PreferenciasUsuario();
    try {
      var desparasitacionAdd = await refRegDesp.add(desparasitacion.toJson());
      await refRegDesp
          .doc(desparasitacionAdd.id)
          .update({"id": desparasitacionAdd.id});

      await refForm
          .doc(idFormu)
          .update({"idDesparasitacion": desparasitacionAdd.id});

      final uid = prefs.uid;

      final fechaProxDesparasitacion =
          desparasitacion.toJson()["fechaProxDesparasitacion"];
      print(fechaProxDesparasitacion);
      final dateFechaProx = DateTime.parse(fechaProxDesparasitacion);
      print(dateFechaProx);

      await refRegDespRoot.doc(desparasitacionAdd.id).set({
        ...desparasitacion.toJson(),
        "fechaProxDesparasitacion": dateFechaProx,
      });

      await refRegDespRoot
          .doc(desparasitacionAdd.id)
          .update({"id": desparasitacionAdd.id, "idCliente": uid});
      //var idFormu1 = idFormu;
      //Navigator.pushNamed(context, 'formularioP3', arguments: idFormu1);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> crearRegistroEvidencias(
      EvidenciasModel evidencia, var idFormu, BuildContext context) async {
    CollectionReference refRegEvi = FirebaseFirestore.instance
        .collection('formularios')
        .doc(idFormu)
        .collection('evidencias');
    try {
      var evidenciaAdd = await refRegEvi.add(evidencia.toJson());
      await refRegEvi.doc(evidenciaAdd.id).update({"id": evidenciaAdd.id});

      await refForm.doc(idFormu).update({"idEvidencia": evidenciaAdd.id});
      //var idFormu1 = idFormu;
      //Navigator.pushNamed(context, 'formularioP3', arguments: idFormu1);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Future<RegistroVacunasModel>>> cargarRegistrosVacunas(
      String idFormu) async {
    var documents = await refForm
        .doc(idFormu)
        .collection('registroVacunas')
        .orderBy('fechaConsulta')
        .get();
    //citas.addAll
    var s = (documents.docs.map((e) async {
      //var data = e.data() as Map<String, dynamic>;

      var vacuna = RegistroVacunasModel.fromJson({
        "id": e.id,
        "fechaConsulta": e["fechaConsulta"],
        "pesoActual": e["pesoActual"],
        "fechaProximaVacuna": e["fechaProximaVacuna"],
        "tipoVacuna": e["tipoVacuna"],
        "veterinarioResp": e["veterinarioResp"],
      });
      return vacuna;
    }));
    return s.toList();
  }

  Future<List<RegistroVacunasModel>> cargarVacunas(String idForm) async {
    final List<RegistroVacunasModel> vacunas = <RegistroVacunasModel>[];
    var documents = await refForm
        .doc(idForm)
        .collection('registroVacunas')
        .orderBy('fechaConsulta', descending: false)
        .get();
    vacunas.addAll(documents.docs.map((e) {
      //var animal = AnimalModel.fromJson(e.data() as Map<String, dynamic>);
      //var data = e.data() as Map<String, dynamic>;
      var vacuna = RegistroVacunasModel.fromJson({
        "id": e.id,
        "fechaConsulta": e["fechaConsulta"],
        "pesoActual": e["pesoActual"],
        "fechaProximaVacuna": e["fechaProximaVacuna"],
        "tipoVacuna": e["tipoVacuna"],
        "veterinarioResp": e["veterinarioResp"],
      });
      return vacuna;
    }).toList());
    return vacunas;
  }

  Future<List<RegistroDesparasitacionModel>> cargarRegDesp(
      String idForm) async {
    final List<RegistroDesparasitacionModel> desparasitaciones =
        <RegistroDesparasitacionModel>[];
    var documents = await refForm
        .doc(idForm)
        .collection('registroDesparasitacion')
        .orderBy('fecha')
        .get();
    desparasitaciones.addAll(documents.docs.map((e) {
      //var data = e.data() as Map<String, dynamic>;
      var desparasitacion = RegistroDesparasitacionModel.fromJson({
        "id": e.id,
        "fecha": e["fecha"],
        "nombreProducto": e["nombreProducto"],
        "pesoActual": e["pesoActual"],
        "fechaProxDesparasitacion": e["fechaProxDesparasitacion"],
      });
      return desparasitacion;
    }).toList());
    return desparasitaciones;
  }

  Future<List<Future<RegistroDesparasitacionModel>>>
      cargarRegistrosDesparasitacion(String idFormu) async {
    // final List<RegistroDesparasitacionModel> desparasitacion =
    //     <RegistroDesparasitacionModel>[];
    var documents = await refForm
        .doc(idFormu)
        .collection('registroDesparasitacion')
        .orderBy('fecha')
        .get();
    //citas.addAll
    var s = (documents.docs.map((e) async {
      //var data = e.data() as Map<String, dynamic>;

      var desparasitacion = RegistroDesparasitacionModel.fromJson({
        "id": e.id,
        "fecha": e["fecha"],
        "nombreProducto": e["nombreProducto"],
        "pesoActual": e["pesoActual"],
        "fechaProxDesparasitacion": e["fechaProxDesparasitacion"],
      });
      return desparasitacion;
    }));
    return s.toList();
  }

  Future<List<Future<EvidenciasModel>>> cargarRegistroEvidencias(
      String idFormu) async {
    //final List<EvidenciasModel> evidencia = <EvidenciasModel>[];
    var documents = await refForm.doc(idFormu).collection('evidencias').get();
    //citas.addAll
    var s = (documents.docs.map((e) async {
      //var data = e.data() as Map<String, dynamic>;

      var evidencia = EvidenciasModel.fromJson({
        "id": e.id,
        "fecha": e["fecha"],
        "fotoUrl": e["fotoUrl"],
        "archivoUrl": e["archivoUrl"],
      });
      return evidencia;
    }));
    return s.toList();
  }

  Future<List<Future<FormulariosModel>>> cargarInfoAnimal(
      String idFormu) async {
    //final List<FormulariosModel> formularios = <FormulariosModel>[];
    var documents = await refForm
        //.where('estado', isEqualTo: 'Aprobado')
        .where('id', isEqualTo: idFormu)
        .get();
    //citas.addAll
    var s = (documents.docs.map((e) async {
      //var animal = AnimalModel.fromJson(e.data() as Map<String, dynamic>);
      //var data = e.data() as Map<String, dynamic>;
      //HorariosModel h1 = new HorariosModel();
      //AnimalModel anim = new AnimalModel();
      //h1 = await horariosProvider.cargarHorarioId(e["idHorario"]);
      //anim = await animalesProvider.cargarAnimalId(e["idAnimal"]);
      var formulario = FormulariosModel.fromJson({
        "id": e.id,
        "idAnimal": e["idAnimal"],
        "fechaIngreso": e["fechaIngreso"],
        "fechaRespuesta": e["fechaRespuesta"],
        "idClient": e["idClient"],
        "nombreClient": e["nombreClient"],
        "identificacion": e["identificacion"],
        "emailClient": e["emailClient"],
        "estado": e["estado"],
        "observacion": e["observacion"],
        "idDatosPersonales": e["idDatosPersonales"],
        "idSituacionFam": e["idSituacionFam"],
        "idDomicilio": e["idDomicilio"],
        "idRelacionAn": e["idRelacionAn"],
        "idVacuna": e["idVacuna"],
        "idDesparasitacion": e["idDesparasitacion"],
        "idEvidencia": e["idEvidencia"],
      });
      //cita.horario = h1;
      //formulario.animal = anim;
      return formulario;
    }));
    return s.toList();
  }

  Future<List<Future<FormulariosModel>>> verificar(
      String identificacion) async {
    var documents =
        await refForm.where('identificacion', isEqualTo: identificacion).get();
    var s = (documents.docs.map((e) async {
      //var data = e.data() as Map<String, dynamic>;
      AnimalModel anim = new AnimalModel();
      anim = await animalesProvider.cargarAnimalId(e["idAnimal"]);
      var formulario = FormulariosModel.fromJson({
        "id": e.id,
        "idAnimal": e["idAnimal"],
        "fechaIngreso": e["fechaIngreso"],
        "fechaRespuesta": e["fechaRespuesta"],
        "idClient": e["idClient"],
        "nombreClient": e["nombreClient"],
        "identificacion": e["identificacion"],
        "emailClient": e["emailClient"],
        "estado": e["estado"],
        "observacion": e["observacion"],
        "idDatosPersonales": e["idDatosPersonales"],
        "idSituacionFam": e["idSituacionFam"],
        "idDomicilio": e["idDomicilio"],
        "idRelacionAn": e["idRelacionAn"],
        "idVacuna": e["idVacuna"],
        "idDesparasitacion": e["idDesparasitacion"],
        "idEvidencia": e["idEvidencia"],
      });
      formulario.animal = anim;
      return formulario;
    }));
    return s.toList();
  }

  //Eliminar registros de desparacitación y vacunas

  Future<int> borrarRegistroVacunas(String idFormu, String id) async {
    await refForm.doc(idFormu).collection('registroVacunas').doc(id).delete();

    return 1;
  }

  Future<int> borrarRegistroDesp(String idFormu, String id) async {
    await refForm
        .doc(idFormu)
        .collection('registroDesparasitacion')
        .doc(id)
        .delete();

    return 1;
  }
}
