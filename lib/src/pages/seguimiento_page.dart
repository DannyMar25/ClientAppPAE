import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter/material.dart';

class SeguimientoPage extends StatefulWidget {
  //const SeguimientoPage({Key? key}) : super(key: key);

  @override
  State<SeguimientoPage> createState() => _SeguimientoPageState();
}

class _SeguimientoPageState extends State<SeguimientoPage> {
  final formKey = GlobalKey<FormState>();
  final prefs = new PreferenciasUsuario();
  FirebaseStorage storage = FirebaseStorage.instance;
  AnimalModel animal = new AnimalModel();
  File? foto;
  DatosPersonalesModel datosA = new DatosPersonalesModel();
  FormulariosModel formularios = new FormulariosModel();
  final userProvider = new UsuarioProvider();
  late int total = 0;

  @override
  void initState() {
    super.initState();
    userProvider.mostrarTotalNotificacion(prefs.uid).then((value) => {
          setState(() {
            print(total);
            total = value;
            print(total);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final email = prefs.email;
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    //if (dat == arg['datosper']) {
    datosA = arg['datosper'] as DatosPersonalesModel;
    print(datosA.id);
    formularios = arg['formulario'] as FormulariosModel;
    animal = arg['animal'] as AnimalModel;
    return Scaffold(
        //backgroundColor: Color.fromARGB(223, 248, 248, 245),
        appBar: AppBar(
          title: Text('Seguimiento de mascota'),
          backgroundColor: Colors.green,
          actions: [
            email != ''
                ? Badge(
                    badgeContent: Text(total.toString(),
                        style: TextStyle(color: Colors.white)),
                    position: BadgePosition.topEnd(top: 3, end: 0),
                    child: IconButton(
                      //onSelected: (item) => onSelected(context, item),
                      icon: Icon(
                        Icons.notifications,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'notificaciones');
                      },
                    ),
                  )
                : SizedBox(),
          ],
        ),
        drawer: _menuWidget(),
        body: Stack(
          alignment: Alignment.center,
          children: [
            //Background(),
            //_verGaleria(context),
            //Text('Hola'),
            SingleChildScrollView(
              child: Flexible(
                fit: FlexFit.loose,
                child: Container(
                  margin: EdgeInsets.all(10),
                  //padding: EdgeInsets.only(bottom: 20),
                  //color: Colors.lightGreenAccent,
                  //padding: new EdgeInsets.only(top: 230.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '${animal.nombre}',
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.blueGrey[600],
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              color: Colors.transparent,
                              height: 5,
                            ),
                            _mostrarFoto(),
                            Divider(
                              color: Colors.transparent,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Nombre: ',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${animal.nombre}',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Etapa de vida: ',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${animal.etapaVida}',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Raza: ',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${animal.raza}',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Color: ',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${animal.color}               ',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Tamaño: ',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${animal.tamanio}      ',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Sexo: ',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${animal.sexo}',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Divider(
                              color: Colors.transparent,
                            ),
                            Text(
                              'Información del adoptante',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blueGrey[600],
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              height: 10,
                              color: Colors.transparent,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Nombre: ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${datosA.nombreCom}  ',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Text(
                                  'Dirección: ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${datosA.direccion}',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Text(
                                  'Teléfono: ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${datosA.telfCel}',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Text(
                                  'Correo: ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${datosA.email}',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Divider(),
                            Divider(
                              height: 10,
                              color: Colors.transparent,
                            ),
                            Text(
                              'Ingresa información de tu mascota',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blueGrey[600],
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        _crearBoton(context),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget obtenerImagenes() {
    Reference ref = storage.ref().child(
        'gs://flutter-varios-1637a.appspot.com/animales/0H05tnjVPjfF1E8DBw0p');

    String url = ref.getDownloadURL() as String;
    //Image.network(url);
    return Image.network(url);
  }

  Widget _mostrarFoto() {
    if (animal.fotoUrl != '') {
      return FadeInImage(
        image: NetworkImage(animal.fotoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 250,
        fit: BoxFit.contain,
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto!,
          fit: BoxFit.cover,
          height: 250.0,
        );
      }
      return Image.asset(foto?.path ?? 'assets/no-image.png');
    }
  }

  // Widget verGaleria(BuildContext context) {
  //   return PhotoViewGallery.builder(
  //     customSize: Size(450.0, 450.0),
  //     itemCount: imageList.length,
  //     builder: (context, index) {
  //       return PhotoViewGalleryPageOptions(
  //         basePosition: Alignment.topCenter,
  //         imageProvider: AssetImage(imageList[index]),
  //         initialScale: PhotoViewComputedScale.contained * 0.9,
  //         minScale: PhotoViewComputedScale.contained * 0.8,
  //         maxScale: PhotoViewComputedScale.covered * 1,
  //       );
  //     },
  //     scrollPhysics: BouncingScrollPhysics(),
  //     backgroundDecoration: BoxDecoration(
  //       color: Theme.of(context).canvasColor,
  //     ),
  //     loadingBuilder: (context, event) =>
  //         Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //       //Center(
  //       // child:
  //       Container(
  //         alignment: Alignment.topCenter,
  //         //width: 20.0,
  //         //height: 20.0,
  //         child: CircularProgressIndicator(
  //           value: event == null
  //               ? 0
  //               : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
  //         ),
  //       ),
  //       // )
  //     ]),
  //   );
  // }

  Widget _crearBoton(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                    //padding: new EdgeInsets.only(top: 5),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      return Colors.green;
                    }),
                  ),
                  label: Text('Agregar vacuna'),
                  icon: Icon(Icons.vaccines),
                  autofocus: true,
                  onPressed: () {
                    // Navigator.pushNamed(context, 'registroVacunas',
                    //     arguments: animal);
                    Navigator.pushNamed(context, 'registroVacunas', arguments: {
                      'datosper': datosA,
                      'formulario': formularios,
                      'animal': animal
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Expanded(
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                        return Colors.green;
                      }),
                    ),
                    label: Text('Agregar desparasitación'),
                    icon: Icon(Icons.medication_liquid_sharp),
                    autofocus: true,
                    onPressed: () {
                      Navigator.pushNamed(context, 'registroDesp', arguments: {
                        'datosper': datosA,
                        'formulario': formularios,
                        'animal': animal
                      });
                    }),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Expanded(
            child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    return Colors.green;
                  }),
                ),
                label: Text('Subir evidencia'),
                icon: Icon(Icons.cloud_upload_outlined),
                autofocus: true,
                onPressed: () {
                  Navigator.pushNamed(context, 'demoArchivos', arguments: {
                    'datosper': datosA,
                    'formulario': formularios,
                    'animal': animal
                  });
                }),
          ),
        ),
      ],
    );
  }

  Widget _menuWidget() {
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
              Icons.manage_search_outlined,
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
                  Icons.list_outlined,
                  color: Colors.green,
                ),
                title: Text('Lista de vacunas'),
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
                leading: Icon(Icons.list, color: Colors.green),
                title: Text('Lista de desparasitaciones'),
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
              Icons.medication_liquid_sharp,
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(Icons.cloud_upload_rounded, color: Colors.green),
            title: Text('Subir evidencia'),
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
