import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EvidenciasPage extends StatefulWidget {
  const EvidenciasPage({Key? key}) : super(key: key);

  @override
  State<EvidenciasPage> createState() => _EvidenciasPageState();
}

class _EvidenciasPageState extends State<EvidenciasPage> {
  final formKey = GlobalKey<FormState>();
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  AnimalesProvider animalesProvider = new AnimalesProvider();

  //List<Future<FormulariosModel>> formulario = [];
  List<FormulariosModel> formularios = [];
  List<Future<FormulariosModel>> listaF = [];
  FirebaseStorage storage = FirebaseStorage.instance;
  AnimalModel animal = new AnimalModel();
  DatosPersonalesModel datosC = new DatosPersonalesModel();
  String identificacion = '';
  bool _guardando = false;
  final prefs = new PreferenciasUsuario();
  final userProvider = new UsuarioProvider();
  @override
  void initState() {
    super.initState();
    //showCitas();
  }

  @override
  Widget build(BuildContext context) {
    final email = prefs.email;
    return Scaffold(
        appBar: AppBar(
          title: Text('Revision de solicitud'),
          backgroundColor: Colors.green,
          actions: [
            Builder(builder: (BuildContext context) {
              return Row(
                children: [
                  email == ''
                      ? TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: Text('Iniciar sesión'),
                        )
                      : TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () async {
                            userProvider.signOut();
                            Navigator.pushNamed(context, 'home');
                          },
                          child: Text('Cerrar sesión'),
                        ),
                  email == ''
                      ? TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(context, 'registro');
                          },
                          child: Text('Registrarse'),
                        )
                      : SizedBox(),
                ],
              );
            }),
          ],
        ),
        drawer: MenuWidget(),
        body: SingleChildScrollView(
            child: Container(
                //color: Colors.lightGreenAccent,
                padding: new EdgeInsets.only(top: 20.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        mostrarImagen1(),
                        _crearCI(),
                        Divider(
                          color: Colors.white,
                        ),
                        _crearBoton(),
                        Divider(
                          color: Colors.white,
                        ),
                        _verListado()
                      ],
                    )))));
  }

  Widget mostrarImagen1() {
    return SizedBox(
      height: 200.0,
      child: Image(
        image: AssetImage('assets/cat_1.gif'),
      ),
    );
  }

  Widget _crearCI() {
    return TextFormField(
      //initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Ingrese su numero de cedula:',
          labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          identificacion = s;
        });
      },
      validator: (value) {
        if (isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            return Colors.green;
          }),
        ),
        label: Text(
          'Verificar',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.verified,
          color: Colors.white,
        ),
        autofocus: true,
        //onPressed: (_guardando) ? null : _submit,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // Si el formulario es válido, queremos mostrar un Snackbar
            //utils.mostrarAlerta(context, 'Datos ingresados correctamente');
            SnackBar(
              content: Text('Informacion ingresada correctamente'),
            );
            _submit();
          } else {
            mostrarAlerta(
                context, 'Asegurate de que todos los campos estan llenos.');
          }
        });
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    setState(() {
      _guardando = true;
    });
    showCitas(identificacion);
//Sentencia If agregada recientemente
    //if (idFormu != null) {

    //formulario = await formulariosProvider.cargarInfo(identificacion);

    //Navigator.pushReplacementNamed(context, 'seguimientoMain');
    // } else {
    //animalProvider.editarAnimal(animal, foto!);
    //print(idFormu);
    // print("Debe llenar la parte 1 para poder continuar");
    //}
  }

  showCitas(String identificacion) async {
    listaF = await formulariosProvider.cargarInfo(identificacion);
    for (var yy in listaF) {
      FormulariosModel form = await yy;
      setState(() {
        formularios.add(form);
      });
    }
  }

  Widget _verListado() {
    return Column(
      children: [
        SizedBox(
          height: 800,
          child: ListView.builder(
            itemCount: formularios.length,
            itemBuilder: (context, i) => _crearItem(context, formularios[i]),
          ),
        ),
      ],
    );
  }

  Widget _crearItem(BuildContext context, FormulariosModel formulario) {
    if (formulario.estado == 'Aprobado') {
      return Card(
          color: Colors.lightGreen[200],
          shadowColor: Colors.green,
          child: InkWell(
            onTap: () async {
              datosC = await formulariosProvider.cargarDPId(
                  formulario.id, formulario.idDatosPersonales);
              animal =
                  await animalesProvider.cargarAnimalId(formulario.idAnimal);

              Navigator.pushNamed(context, 'seguimientoMain', arguments: {
                'datosper': datosC,
                'formulario': formulario,
                'animal': animal
              });
            },
            child: Column(
              children: [
                ListTile(
                  title: Column(
                    children: [
                      //Divider(color: Colors.purple),
                      Text("Nombre del cliente: " +
                          '${formulario.nombreClient}'),
                      Text("Numero de cedula: " '${formulario.identificacion}'),
                      Text("Su solicitud de adopción fue:"
                          '${formulario.estado}'),
                      Text("Fecha de aprobación de solicitud: "
                          '${formulario.fechaRespuesta}'),
                      Text("Nombre mascota adopatada:"
                          '${formulario.animal!.nombre}'),
                      //Divider(color: Colors.purple)
                    ],
                  ),
                  //subtitle: Text('${horario}'),
                ),
                SizedBox(
                  height: 150.0,
                  child: Image(
                    image: AssetImage('assets/dog_an8.gif'),
                  ),
                ),
                Text(
                  '¡Haz click aquí!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ));
    } else if (formulario.estado == 'Pendiente') {
      return Card(
          color: Colors.lightGreen[200],
          shadowColor: Colors.green,
          child: InkWell(
            onTap: () async {
              // datosC = await formulariosProvider.cargarDPId(
              //     formulario.id, formulario.idDatosPersonales);
              // animal =
              //     await animalesProvider.cargarAnimalId(formulario.idAnimal);

              // Navigator.pushNamed(context, 'seguimientoMain', arguments: {
              //   'datosper': datosC,
              //   'formulario': formulario,
              //   'animal': animal
              // });
            },
            child: Column(
              children: [
                ListTile(
                  title: Column(
                    children: [
                      //Divider(color: Colors.purple),
                      Text("Nombre del cliente: " +
                          '${formulario.nombreClient}'),
                      Text("Numero de cedula: " '${formulario.identificacion}'),
                      Text("Su solicitud de adopcion fue:"
                          '${formulario.estado}'),
                      Text("Nombre mascota adopatada:"
                          '${formulario.animal!.nombre}'),
                      //Divider(color: Colors.purple)
                    ],
                  ),
                  //subtitle: Text('${horario}'),
                ),
                SizedBox(
                  height: 200.0,
                  child: Image(
                    image: AssetImage('assets/cat_4.gif'),
                  ),
                )
              ],
            ),
          ));
    } else {
      return Card(
          color: Colors.lightGreen[200],
          shadowColor: Colors.green,
          child: InkWell(
            onTap: () async {
              // datosC = await formulariosProvider.cargarDPId(
              //     formulario.id, formulario.idDatosPersonales);
              // animal =
              //     await animalesProvider.cargarAnimalId(formulario.idAnimal);

              // Navigator.pushNamed(context, 'seguimientoMain', arguments: {
              //   'datosper': datosC,
              //   'formulario': formulario,
              //   'animal': animal
              // });
            },
            child: Column(
              children: [
                ListTile(
                  title: Column(
                    children: [
                      //Divider(color: Colors.purple),
                      Text("Nombre del cliente: " +
                          '${formulario.nombreClient}'),
                      Text("Numero de cedula: " '${formulario.identificacion}'),
                      Text("Su solicitud de adopcion fue:"
                          '${formulario.estado}'),
                      Text("Nombre mascota adopatada:"
                          '${formulario.animal!.nombre}'),
                      //Divider(color: Colors.purple)
                    ],
                  ),
                  //subtitle: Text('${horario}'),
                ),
                SizedBox(
                  height: 200.0,
                  child: Image(
                    image: AssetImage('assets/cat_6.gif'),
                  ),
                )
              ],
            ),
          ));
    }
  }
}
