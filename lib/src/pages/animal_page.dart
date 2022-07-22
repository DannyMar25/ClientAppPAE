import 'dart:io';

import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
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
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final email = prefs.email;
    final Object? animData = ModalRoute.of(context)!.settings.arguments;
    if (animData != null) {
      animal = animData as AnimalModel;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Animal'),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearEspecie(),
                _crearNombre(),
                _crearSexo(),
                _crearEdad(),
                _crearTemperamento(),
                _crearPeso(),
                _crearTamanio(),
                _crearColor(),
                _crearRaza(),
                _crearEsterilizado(),
                _crearCaracteristicas(),
                Padding(padding: EdgeInsets.only(bottom: 20.0)),
                cardEtapasVida(),
                Padding(padding: EdgeInsets.only(bottom: 20.0)),
                cardCita(),
                Padding(padding: EdgeInsets.only(bottom: 10.0)),
                //_crearBotonCita(),
                Padding(padding: EdgeInsets.only(bottom: 20.0)),
                cardAdopcion(),
                Padding(padding: EdgeInsets.only(bottom: 10.0)),
                //_crearBotonAdopta(),
                // _crearDisponible(),
                // _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearEspecie() {
    return TextFormField(
      initialValue: animal.especie,
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Especie',
      ),
      onSaved: (value) => animal.especie = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese la especie de la mascota';
        } else {
          return null;
        }
      },
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
      initialValue: animal.etapaVida,
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      //keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Etapa de vida',
      ),
      onSaved: (value) => animal.etapaVida = value!,
      // validator: (value) {
      //   if (utils.isNumeric(value!)) {
      //     return null;
      //   } else {
      //     return 'Solo numeros';
      //   }
      // },
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
      initialValue: animal.peso.toString() + ' ' + 'Kg.',
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

  Widget _crearEsterilizado() {
    return TextFormField(
      initialValue: animal.esterilizado,
      readOnly: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Esterilizado',
      ),
      onSaved: (value) => animal.especie = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese la especie de la mascota';
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

  Widget _crearBotonCita() {
    //final email = prefs.email;
    return TextButton(
      style: TextButton.styleFrom(
          //backgroundColor: Color.fromARGB(255, 170, 235, 164),
          shadowColor: Colors.lightGreen,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      onPressed: () {
        Navigator.pushNamed(context, 'registroCita', arguments: animal);
      },
      child: Column(
        children: <Widget>[
          Icon(
            Icons.date_range,
            color: Color.fromARGB(255, 3, 86, 97),
            size: 80.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
          ),
          Text(
            'Agendar cita',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
    //Padding(padding: EdgeInsets.only(right: 10.0)),
  }

  Widget _crearBotonAdopta() {
    final email = prefs.email;
    return TextButton(
      style: TextButton.styleFrom(
          //backgroundColor: Color.fromARGB(255, 226, 155, 233),
          shadowColor: Colors.lightGreen,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      onPressed: () {
        if (email != '') {
          Navigator.pushReplacementNamed(context, 'formularioMain',
              arguments: animal);
        } else {
          mostrarAlertaOkCancel(
              context,
              'Para poder ingresar al formulario, debe registrarse o iniciar sesión.',
              'login',
              animal);
        }
      },
      child: Column(
        children: <Widget>[
          Icon(
            Icons.pets,
            color: Colors.green,
            size: 60.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
          ),
          Text(
            '¡Quiero Adoptarlo!',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
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

  Widget cardEtapasVida() {
    return Card(
      child: Container(
        height: 150,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              height: 110,
              width: 110,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Expanded(
                  child: Image.asset("assets/dog_an3.gif"),
                  flex: 2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child: ListTile(
                          title: Text(
                            "Etapas de Vida",
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Column(
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 5.0)),
                              Text("Cachorro: 0 a 6 meses"),
                              Text("Joven: 7 meses a 2 años"),
                              Text("Adulto: 2 a 6 años"),
                              Text("Anciano: 7 a 11 años"),
                              Text("Geriátrico: mayor a 12 años"),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
      shadowColor: Colors.green,
    );
  }

  Widget cardCita() {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'registroCita', arguments: animal);
        },
        child: Container(
          height: 110,
          color: Colors.white,
          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Expanded(
                    child: Image.asset("assets/dog_an8.gif"),
                    flex: 2,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 5,
                          child: ListTile(
                            title: Text("Agenda una cita!"),
                            subtitle: Text(
                              "Si deseas conocer a ${animal.nombre} puedes visitarnos agendando tu cita con anticipcion.",
                              textAlign: TextAlign.justify,
                            ),
                          )),
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text("Agendar"),
                              onPressed: () {
                                Navigator.pushNamed(context, 'registroCita',
                                    arguments: animal);
                              },
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            TextButton(
                              child: Text("Volver a galeria"),
                              onPressed: () {
                                Navigator.pushNamed(context, 'home');
                              },
                            ),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 8,
              ),
            ],
          ),
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
      shadowColor: Colors.green,
    );
  }

  Widget cardAdopcion() {
    final email = prefs.email;
    return Card(
      child: InkWell(
        onTap: () {
          if (email != '') {
            Navigator.pushReplacementNamed(context, 'formularioMain',
                arguments: animal);
          } else {
            mostrarAlertaOkCancel(
                context,
                'Para poder ingresar al formulario, debe registrarse o iniciar sesión.',
                'login',
                animal);
          }
        },
        child: Container(
          height: 110,
          color: Colors.white,
          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Expanded(
                    child: Image.asset("assets/dog_an7.gif"),
                    flex: 2,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 5,
                          child: ListTile(
                            title: Text("Deseas adoptar a ${animal.nombre}!"),
                            subtitle: Text(
                              "Si deseas adoptarlo debes llenar el formulario de adopcion.",
                              textAlign: TextAlign.justify,
                            ),
                          )),
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text("Adoptarlo!"),
                              onPressed: () {
                                if (email != '') {
                                  Navigator.pushReplacementNamed(
                                      context, 'formularioMain',
                                      arguments: animal);
                                } else {
                                  mostrarAlertaOkCancel(
                                      context,
                                      'Para poder ingresar al formulario, debe registrarse o iniciar sesión.',
                                      'login',
                                      animal);
                                }
                              },
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            TextButton(
                              child: Text("Volver a galeria"),
                              onPressed: () {
                                Navigator.pushNamed(context, 'home');
                              },
                            ),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 8,
              ),
            ],
          ),
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
      shadowColor: Colors.green,
    );
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
