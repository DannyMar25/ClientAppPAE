import 'dart:io';

import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/evidencia_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/providers/firebase_api.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/button_widget.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SubirArchivosPage extends StatefulWidget {
  @override
  _SubirArchivosPageState createState() => _SubirArchivosPageState();
}

class _SubirArchivosPageState extends State<SubirArchivosPage> {
  UploadTask? task;
  UploadTask? task1;
  File? file;
  File? foto;
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  EvidenciasModel evidencia = new EvidenciasModel();
  AnimalModel animal = new AnimalModel();
  FormulariosModel formularios = new FormulariosModel();
  DatosPersonalesModel datosA = new DatosPersonalesModel();
  String fecha = '';
  String fotoUrl = '';
  String archivoUrl = '';
  String nombreArchivo = '';

  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null
        ? basename(file!.path)
        : 'No se ha seleccionado un archivo';
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    datosA = arg['datosper'] as DatosPersonalesModel;
    //if (dat == arg['datosper']) {
    formularios = arg['formulario'] as FormulariosModel;
    animal = arg['animal'] as AnimalModel;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 210, 212),
      appBar: AppBar(
        title: Text('Subir archivos'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      drawer: _menuWidget(context),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/fondoanimales.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        padding: EdgeInsets.all(32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _mostrarFoto(),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith(
                              (Set<MaterialState> states) {
                        return Colors.green;
                      })),
                      icon: Icon(Icons.photo_camera),
                      label: Text('Tomar foto'),
                      onPressed: _tomarFoto,
                    ),
                    Padding(padding: EdgeInsets.only(right: 35.0)),
                    ElevatedButton.icon(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith(
                              (Set<MaterialState> states) {
                        return Colors.green;
                      })),
                      icon: Icon(Icons.photo_album),
                      label: Text('Seleccionar foto'),
                      onPressed: _seleccionarFoto,
                    ),
                  ],
                ),
                // ButtonWidget(
                //     icon: Icons.photo_camera,
                //     text: 'Tomar foto',
                //     onClicked: _tomarFoto),
                // ButtonWidget(
                //     icon: Icons.photo_camera,
                //     text: 'Seleccionar foto',
                //     onClicked: _seleccionarFoto),
                Divider(),
                ElevatedButton.icon(
                  // style: ButtonStyle(backgroundColor:
                  //     MaterialStateProperty.resolveWith(
                  //         (Set<MaterialState> states) {
                  //   return Colors.green;
                  // })),
                  label: Text(
                    'Subir Foto',
                    style: TextStyle(fontSize: 20),
                  ),
                  icon: Icon(Icons.cloud_upload_outlined),
                  onPressed: uploadFoto,
                ),
                SizedBox(height: 30),
                task != null ? buildUploadStatus(task!) : Container(),
                Divider(),
                ElevatedButton.icon(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                    return Colors.green;
                  })),
                  label: Text(
                    'Seleccionar Archivo',
                    style: TextStyle(fontSize: 16),
                  ),
                  icon: Icon(Icons.attach_file),
                  onPressed: selectFile,
                ),
                SizedBox(height: 10),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  label: Text(
                    'Subir Archivo',
                    style: TextStyle(fontSize: 20),
                  ),
                  icon: Icon(Icons.cloud_upload_outlined),
                  onPressed: uploadFile,
                ),
                SizedBox(height: 15),
                task1 != null ? buildUploadStatus1(task1!) : Container(),
                Divider(),
                Padding(padding: EdgeInsets.only(bottom: 20.0)),
                _crearBoton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    //Linea modificadas cambio de allowMultiple a false y se anadio type para solo permitir pdf
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;
    final path = result.files.single.path!;
    //List<File> files = result.paths.map((path) => File(path!)).toList();

    setState(() => file = File(path));
    //setState(() => files = File(path) as List<File>);
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination =
        'Evidencias/Archivos/${formularios.identificacion}/${formularios.nombreClient + "-" + fileName}';

    task1 = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task1 == null) return;

    final snapshot = await task1!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    archivoUrl = urlDownload;
    nombreArchivo = formularios.nombreClient + "-" + fileName;
    print('Download-Link: $urlDownload');
  }

  Future uploadFoto() async {
    if (foto == null) return;

    final fileName = basename(foto!.path);
    final destination =
        'Evidencias/Fotos/${formularios.identificacion}/${formularios.nombreClient + "-" + fileName}';

    task = FirebaseApi.uploadFile(destination, foto!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    fotoUrl = urlDownload;

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  Widget buildUploadStatus1(UploadTask task1) => StreamBuilder<TaskSnapshot>(
        stream: task1.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
  Widget _mostrarFoto() {
    if (foto != null) {
      return Image.file(
        foto!,
        fit: BoxFit.cover,
        height: 300.0,
      );
    }
    return Image.asset(foto?.path ?? 'assets/no-image.png');
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final _picker = ImagePicker();
    final pickedFile =
        await _picker.getImage(source: origen, maxHeight: 720, maxWidth: 720);
    foto = File(pickedFile!.path);

    setState(() {});
  }

  Widget _crearBoton(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton.icon(
            style: ButtonStyle(
              //padding: new EdgeInsets.only(top: 5),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return Colors.green;
              }),
            ),
            label:
                Text('Guardar fotos/archivos', style: TextStyle(fontSize: 20)),
            icon: Icon(Icons.save),
            autofocus: true,
            onPressed: () {
              evidencia.fecha = DateTime.now().toString();
              evidencia.fotoUrl = fotoUrl;
              evidencia.archivoUrl = archivoUrl;
              evidencia.nombreArchivo = nombreArchivo;

              formulariosProvider.crearRegistroEvidencias(
                  evidencia, formularios.id, context);
              //Navigator.pushReplacementNamed(context, '');
            }),
      ])
    ]);
  }

  Widget _menuWidget(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pet-care.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.pages,
              color: Colors.green,
            ),
            title: Text('Seguimiento Home'),
            onTap: () => Navigator.pushReplacementNamed(
                context, 'seguimientoMain', arguments: {
              'datosper': datosA,
              'formulario': formularios,
              'animal': animal
            }),
          ),
          ExpansionTile(
            title: Text('Registro de Vacunas'),
            children: [
              ListTile(
                leading: Icon(
                  Icons.meeting_room,
                  color: Colors.green,
                ),
                title: Text('Realizar registro'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'registroVacunas',
                      arguments: {
                        'datosper': datosA,
                        'formulario': formularios,
                        'animal': animal
                      });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                title: Text('Ver registros'),
                onTap: () => Navigator.pushReplacementNamed(
                    context, 'verRegistroVacunas', arguments: {
                  'datosper': datosA,
                  'formulario': formularios,
                  'animal': animal
                }),
              ),
            ],
            leading: Icon(
              Icons.assignment,
              color: Colors.green,
            ),
          ),
          ExpansionTile(
            title: Text('Registro de Desparasitacion'),
            children: [
              ListTile(
                leading: Icon(Icons.settings, color: Colors.green),
                title: Text('Registro Desparasitacion'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'registroDesp',
                      arguments: {
                        'datosper': datosA,
                        'formulario': formularios,
                        'animal': animal
                      });
                },
              ),
              ListTile(
                leading: Icon(Icons.check, color: Colors.green),
                title: Text('Ver Registro Desparasitacion'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'verRegistroDesp',
                      arguments: {
                        'datosper': datosA,
                        'formulario': formularios,
                        'animal': animal
                      });
                },
              ),
            ],
            leading: Icon(
              Icons.assignment,
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.green),
            title: Text('Cargar Evidencia'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'demoArchivos',
                  arguments: {
                    'datosper': datosA,
                    'formulario': formularios,
                    'animal': animal
                  });
            },
          ),
        ],
      ),
    );
  }
}
