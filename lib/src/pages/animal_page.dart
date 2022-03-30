import 'dart:io';

import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cliente_app_v1/src/utils/utils.dart' as utils;
//import 'package:image_picker/image_picker.dart';
//import 'package:firebase_core/firebase_core.dart';

class AnimalPage extends StatefulWidget {
  //const ProductoPage({Key? key}) : super(key: key);

  @override
  _AnimalPageState createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animalProvider = new AnimalesProvider();
  final userProvider = new UsuarioProvider();

  AnimalModel animal = new AnimalModel();
  //bool _guardando = false;
  File? foto;
  @override
  Widget build(BuildContext context) {
    final Object? animData = ModalRoute.of(context)!.settings.arguments;
    if (animData != null) {
      animal = animData as AnimalModel;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Animal'),
        actions: [
          Builder(builder: (BuildContext context) {
            return TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                userProvider.signOut();
                Navigator.pushNamed(context, 'home');
              },
              child: Text('Sign Out'),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearSexo(),
                _crearEdad(),
                _crearTemperamento(),
                _crearPeso(),
                _crearTamanio(),
                _crearColor(),
                _crearRaza(),
                _crearCaracteristicas(),
                _crearBoton(),
                // _crearDisponible(),
                // _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: animal.nombre,
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
      ),
      onSaved: (value) => animal.nombre = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese el nombre de la mascota';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearSexo() {
    return TextFormField(
      initialValue: animal.sexo,
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Sexo',
      ),
      onSaved: (value) => animal.nombre = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese el nombre de la mascota';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearEdad() {
    return TextFormField(
      initialValue: animal.edad.toString(),
      readOnly: true,
      //textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Edad',
      ),
      onSaved: (value) => animal.edad = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearTemperamento() {
    return TextFormField(
      initialValue: animal.temperamento,
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Temperamento',
      ),
      onSaved: (value) => animal.temperamento = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese el temperamento de la mascota';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPeso() {
    return TextFormField(
      initialValue: animal.peso.toString(),
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Peso',
      ),
      onSaved: (value) => animal.peso = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearTamanio() {
    return TextFormField(
      initialValue: animal.tamanio.toString(),
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Tamaño',
      ),
      onSaved: (value) => animal.tamanio = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese el tamanio de la mascota';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearColor() {
    return TextFormField(
      initialValue: animal.color,
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Color',
      ),
      onSaved: (value) => animal.color = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese el color de la mascota';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearRaza() {
    return TextFormField(
      initialValue: animal.raza,
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Raza',
      ),
      onSaved: (value) => animal.raza = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese la raza de la mascota';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCaracteristicas() {
    return TextFormField(
      initialValue: animal.caracteristicas,
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Caracteristicas',
      ),
      onSaved: (value) => animal.caracteristicas = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese las caracteristicas especiales';
        } else {
          return null;
        }
      },
    );
  }

  //Widget _crearDisponible() {
  //return SwitchListTile(
  //value: producto.disponible,
  // title: Text('Disponible'),
  //activeColor: Colors.deepPurple,
  //onChanged: (value) => setState(() {
  //producto.disponible = value;
  // }),
  //);
  //}

  Widget _crearBoton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
            style: ButtonStyle(
              //padding: new EdgeInsets.only(top: 5),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return Colors.deepPurple;
              }),
            ),
            label: Text('Agendar cita'),
            icon: Icon(Icons.save),
            autofocus: true,
            onPressed: () {
              Navigator.pushNamed(context, 'registroCita', arguments: animal);
            }),
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Colors.deepPurple;
                }),
              ),
              label: Text('Llenar formulario'),
              icon: Icon(Icons.save),
              autofocus: true,
              onPressed: () {
                mostrarAlertaOkCancel(
                    context,
                    'Para poder ingresar al formulario, debe registrarse o iniciar sesion.',
                    'login',
                    animal);
                //Navigator.pushNamed(context, 'formularioMain');
              }),
        ),
      ],
    );
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    if (animal.fotoUrl != '') {
      return FadeInImage(
        image: NetworkImage(animal.fotoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300,
        fit: BoxFit.contain,
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto!,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset(foto?.path ?? 'assets/no-image.png');
    }
  }

  // _seleccionarFoto() async {
  //   _procesarImagen(ImageSource.gallery);
  // }

  // _tomarFoto() {
  //   _procesarImagen(ImageSource.camera);
  // }

  // _procesarImagen(ImageSource origen) async {
  //   final _picker = ImagePicker();
  //   final pickedFile =
  //       await _picker.getImage(source: origen, maxHeight: 720, maxWidth: 720);
  //   foto = File(pickedFile!.path);
  //   if (foto != null) {
  //     animal.fotoUrl = '';
  //   }
  //   setState(() {});
  // }
}
