import 'dart:io';

import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/evidencia_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/providers/firebase_api.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';

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
  final formKey = GlobalKey<FormState>();
  UploadTask? task;
  UploadTask? task1;
  File? file;
  File? foto;
  bool isDisable = true;
  bool cargadoArchivo = false;
  bool cargadoFoto = false;
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  EvidenciasModel evidencia = new EvidenciasModel();
  AnimalModel animal = new AnimalModel();
  FormulariosModel formularios = new FormulariosModel();
  DatosPersonalesModel datosA = new DatosPersonalesModel();
  String fecha = '';
  String fotoUrl = '';
  String archivoUrl = '';
  String nombreArchivo = '';
  final List<String> _items =
      ['Foto', 'Documento', 'Foto y documento'].toList();
  String? _selection = "Foto";

  @override
  void initState() {
    _crearSeleccion();
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null
        ? basename(file!.path)
        : 'No se ha seleccionado un documento';
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    datosA = arg['datosper'] as DatosPersonalesModel;
    //if (dat == arg['datosper']) {
    formularios = arg['formulario'] as FormulariosModel;
    animal = arg['animal'] as AnimalModel;
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 206, 210, 212),
      backgroundColor: Color.fromARGB(223, 248, 248, 245),
      appBar: AppBar(
        title: Text('Subir evidencia'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      drawer: _menuWidget(context),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _crearSeleccion(),
                Padding(padding: EdgeInsets.only(bottom: 15.0)),
                buildChild(fileName, context),
                // Divider(
                //   color: Colors.transparent,
                // ),
                // Padding(padding: EdgeInsets.only(bottom: 10.0)),
                // _crearBoton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearTomarFoto() {
    return Expanded(
      child: ElevatedButton.icon(
        style: ButtonStyle(backgroundColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          return Colors.green;
        })),
        icon: Icon(Icons.photo_camera),
        label: Text('Tomar foto'),
        onPressed: _tomarFoto,
      ),
    );
  }

  Widget _crearSeleccionarFoto() {
    return Expanded(
      child: ElevatedButton.icon(
        style: ButtonStyle(backgroundColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          return Colors.green;
        })),
        icon: Icon(Icons.photo_album),
        label: Text('Seleccionar de galería'),
        onPressed: _seleccionarFoto,
      ),
    );
  }

  Widget _crearCargarFoto() {
    return ElevatedButton.icon(
      label: Text(
        'Cargar foto',
        style: TextStyle(fontSize: 20),
      ),
      icon: Icon(Icons.cloud_upload_outlined),
      onPressed: uploadFoto,
    );
  }

  Widget _crearSelecArchivo() {
    return ElevatedButton.icon(
      style: ButtonStyle(backgroundColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        return Colors.green;
      })),
      label: Text(
        'Seleccionar Archivo',
        style: TextStyle(fontSize: 16),
      ),
      icon: Icon(Icons.attach_file),
      onPressed: selectFile,
    );
  }

  Widget _crearCargarArchivo() {
    return ElevatedButton.icon(
      label: Text(
        'Cargar documento',
        style: TextStyle(fontSize: 20),
      ),
      icon: Icon(Icons.cloud_upload_outlined),
      onPressed: uploadFile,
    );
  }

  Widget _crearSeleccion() {
    final dropdownMenuOptions = _items
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Seleccione el tipo de archivo:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Padding(padding: EdgeInsets.only(top: 10.0)),
        DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: SizedBox(
              width: 210.0,
              child: DropdownButtonFormField<String>(
                  //hint: Text(animal.tamanio.toString()),
                  value: _selection,
                  items: dropdownMenuOptions,
                  validator: (value) =>
                      value == null ? 'Selecciona una opción' : null,
                  onChanged: (s) {
                    setState(() {
                      _selection = s;
                      //animal.tamanio = s!;
                    });
                  }),
            ),
          ),
        ),
      ],
    );
  }

  buildChild(String fileName, BuildContext context) {
    if (_selection == 'Foto') {
      return Column(
        children: [
          _mostrarFoto(),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _crearTomarFoto(),
              Padding(padding: EdgeInsets.only(right: 35.0)),
              _crearSeleccionarFoto()
            ],
          ),
          Divider(),
          _crearCargarFoto(),
          SizedBox(height: 30),
          task != null ? buildUploadStatus(task!) : Container(),
          //Divider(),
          Divider(
            color: Colors.transparent,
          ),
          Padding(padding: EdgeInsets.only(bottom: 10.0)),
          _crearBoton(context),
        ],
      );
    } else if (_selection == 'Documento') {
      return Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Icon(
              Icons.description_outlined,
              size: 80,
            ),
          ),
          _crearSelecArchivo(),
          SizedBox(height: 10),
          Text(
            fileName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 40),
          _crearCargarArchivo(),
          SizedBox(height: 15),
          task1 != null ? buildUploadStatus1(task1!) : Container(),
          Divider(
            color: Colors.transparent,
          ),
          Padding(padding: EdgeInsets.only(bottom: 10.0)),
          _crearBoton(context),
        ],
      );
    } else if (_selection == 'Foto y documento') {
      return Column(children: [
        _mostrarFoto(),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _crearTomarFoto(),
            Padding(padding: EdgeInsets.only(right: 35.0)),
            _crearSeleccionarFoto()
          ],
        ),
        Divider(),
        _crearCargarFoto(),
        SizedBox(height: 30),
        task != null ? buildUploadStatus(task!) : Container(),
        Divider(),
        SizedBox(
          height: 100,
          width: 100,
          child: Icon(
            Icons.description_outlined,
            size: 80,
          ),
        ),
        Divider(),
        _crearSelecArchivo(),
        SizedBox(height: 10),
        Text(
          fileName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 40),
        _crearCargarArchivo(),
        SizedBox(height: 15),
        task1 != null ? buildUploadStatus1(task1!) : Container(),
        Divider(
          color: Colors.transparent,
        ),
        Padding(padding: EdgeInsets.only(bottom: 10.0)),
        _crearBoton(context),
      ]);
    } else {
      return SizedBox();
    }
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
    cargadoArchivo = true;
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
    cargadoFoto = true;

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
    final pickedFile = await _picker.pickImage(
        source: origen, maxHeight: 620, maxWidth: 620); //getImage
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
                // if (isDisable == true) {
                //   return Colors.grey;
                // } else {
                return Colors.green;
                //}
              }),
            ),
            label:
                Text('Guardar foto/documento', style: TextStyle(fontSize: 16)),
            icon: Icon(Icons.save),
            autofocus: true,
            onPressed: () {
              if (cargadoFoto == true || cargadoArchivo == true) {
                if (fotoUrl != '' || archivoUrl != '') {
                  isDisable = false;
                  evidencia.fecha = DateTime.now().toString();
                  evidencia.fotoUrl = fotoUrl;
                  evidencia.archivoUrl = archivoUrl;
                  evidencia.nombreArchivo = nombreArchivo;

                  formulariosProvider.crearRegistroEvidencias(
                      evidencia, formularios.id, context);
                  mostrarOkRegistros(
                      context,
                      'Evidencia guardada con éxito.',
                      'Información correcta',
                      'seguimientoMain',
                      datosA,
                      formularios,
                      animal);
                } else {
                  isDisable = true;
                  mostrarAlerta(context, 'Debe cargar una foto o un archivo.');
                  return null;
                }
              } else {
                mostrarAlerta(context,
                    'Asegúrate de que el archivo seleccionado sea el correcto y luego da clic en el botón "Cargar" para poder guardar la evidencia.');
              }
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
            leading: Icon(Icons.home, color: Colors.green),
            title: Text('Inicio'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushNamed(
                context,
                'intro',
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.manage_search_rounded,
              color: Colors.green,
            ),
            title: Text('Seguimiento de mascota'),
            onTap: () => Navigator.pushNamed(context, 'seguimientoMain',
                arguments: {
                  'datosper': datosA,
                  'formulario': formularios,
                  'animal': animal
                }),
          ),
          ExpansionTile(
            title: Text('Vacunas'),
            children: [
              ListTile(
                leading: Icon(
                  Icons.edit_outlined,
                  color: Colors.green,
                ),
                title: Text('Agregar nuevo registro'),
                onTap: () {
                  Navigator.pushNamed(context, 'registroVacunas', arguments: {
                    'datosper': datosA,
                    'formulario': formularios,
                    'animal': animal
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.edit_outlined,
                  color: Colors.green,
                ),
                title: Text('Agregar nuevo registro'),
                onTap: () => Navigator.pushNamed(context, 'verRegistroVacunas',
                    arguments: {
                      'datosper': datosA,
                      'formulario': formularios,
                      'animal': animal
                    }),
              ),
            ],
            leading: Icon(
              Icons.vaccines,
              color: Colors.green,
            ),
          ),
          ExpansionTile(
            title: Text('Desparasitaciones'),
            children: [
              ListTile(
                leading: Icon(Icons.edit_outlined, color: Colors.green),
                title: Text('Agregar nuevo registro'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, 'registroDesp', arguments: {
                    'datosper': datosA,
                    'formulario': formularios,
                    'animal': animal
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.check, color: Colors.green),
                title: Text('Llista de desparacitaciones'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, 'verRegistroDesp', arguments: {
                    'datosper': datosA,
                    'formulario': formularios,
                    'animal': animal
                  });
                },
              ),
            ],
            leading: Icon(
              Icons.medication_liquid_rounded,
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(Icons.cloud_upload_rounded, color: Colors.green),
            title: Text('Subir Evidencia'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushNamed(context, 'demoArchivos', arguments: {
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
