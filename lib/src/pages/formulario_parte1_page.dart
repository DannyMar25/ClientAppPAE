import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cliente_app_v1/src/utils/utils.dart' as utils;

class FormDatPersonalesPage extends StatefulWidget {
  //const formDatPersonalesPage({Key? key}) : super(key: key);

  @override
  _FormDatPersonalesPageState createState() => _FormDatPersonalesPageState();
}

class _FormDatPersonalesPageState extends State<FormDatPersonalesPage> {
  bool _guardando = false;
  FormulariosModel formulario = new FormulariosModel();
  DatosPersonalesModel datoPersona = new DatosPersonalesModel();
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  final formKey = GlobalKey<FormState>();
  final List<String> _items =
      ['Primaria', 'Secundaria', 'Universidad', 'Posgrado'].toList();
  String? _selection;
  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  AnimalModel animal = new AnimalModel();
  @override
  Widget build(BuildContext context) {
    // final Object? formData = ModalRoute.of(context)!.settings.arguments;
    // if (formData != null) {
    //   formulario = formData as FormulariosModel;
    //   print(formulario.id);
    // }
    final Object? animData = ModalRoute.of(context)!.settings.arguments;
    if (animData != null) {
      animal = animData as AnimalModel;
      print(animal.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DATOS PERSONALES',
          // textAlign: TextAlign.center,
        ),
      ),
      drawer: MenuWidget(),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Datos personales',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      _crearNombre(),
                      _crearCI(),
                      _crearDireccion(),
                      _crearEdad(),
                      _crearOcupacion(),
                      _crearEmail(),
                      Divider(),
                      Text(
                        'Instrucción',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                      ),
                      Divider(),
                      _crearInstruccion(),
                      Divider(),
                      Text(
                        'Telefonos de contacto',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      _crearTelfCelular(),
                      _crearTelfDomicilio(),
                      _crearTelfTrabajo(),
                      Divider(),
                      Text(
                        'Referencias Personales',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      _crearNombreRef(),
                      _crearParentescoRef(),
                      _crearTelefonoRef(),
                      Divider(),
                      _crearBoton(context),
                      _crearBoton1(context)
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: datoPersona.nombreCom,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Nombre Completo',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          formulario.nombreClient = s;
          datoPersona.nombreCom = s;
        });
      },
    );
  }

  Widget _crearCI() {
    return TextFormField(
      initialValue: datoPersona.cedula,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Cedula',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          formulario.identificacion = s;
          datoPersona.cedula = s;
        });
      },
    );
  }

  Widget _crearEdad() {
    return TextFormField(
      initialValue: datoPersona.edad.toString(),
      readOnly: false,
      //textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: 'Edad',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onSaved: (value) => datoPersona.edad = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearOcupacion() {
    return TextFormField(
      initialValue: datoPersona.ocupacion,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Ocupacion',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.ocupacion = s;
        });
      },
    );
  }

  Widget _crearEmail() {
    return TextFormField(
      initialValue: datoPersona.email,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'E-mail',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.email = s;
        });
      },
    );
  }

  Widget _crearDireccion() {
    return TextFormField(
      initialValue: datoPersona.direccion,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Direccion exacta donde estara la mascota',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.direccion = s;
        });
      },
    );
  }

  Widget _crearInstruccion() {
    final dropdownMenuOptions = _items
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Seleccione nivel de instruccion: ',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection = s;

                datoPersona.nivelInst = s!;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearTelfDomicilio() {
    return TextFormField(
      initialValue: datoPersona.telfDomi,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Telefono de domicilio',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.telfDomi = s;
        });
      },
    );
  }

  Widget _crearTelfCelular() {
    return TextFormField(
      initialValue: datoPersona.telfCel,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Telefono celular',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.telfCel = s;
        });
      },
    );
  }

  Widget _crearTelfTrabajo() {
    return TextFormField(
      initialValue: datoPersona.telfTrab,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Telefono de trabajo',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.telfTrab = s;
        });
      },
    );
  }

  Widget _crearNombreRef() {
    return TextFormField(
      initialValue: datoPersona.nombreRef,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Nombre',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.nombreRef = s;
        });
      },
    );
  }

  Widget _crearParentescoRef() {
    return TextFormField(
      initialValue: datoPersona.parentescoRef,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Parentesco',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.parentescoRef = s;
        });
      },
    );
  }

  Widget _crearTelefonoRef() {
    return TextFormField(
      initialValue: datoPersona.telfRef,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Telefono',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.telfRef = s;
        });
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          return Colors.deepPurple;
        }),
      ),
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      autofocus: true,
      onPressed: (_guardando) ? null : _submit,
    );
  }

  Widget _crearBoton1(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          return Colors.deepPurple;
        }),
      ),
      label: Text('Siguiente'),
      icon: Icon(Icons.save),
      autofocus: true,
      onPressed: _onPressed1,
      //onPressed: () {
      //print("Hola ID:" + );
      // Navigator.pushNamed(context, 'formularioP2', arguments: formulario);
      //
      //},
    );
  }

  void _onPressed1() {
    FirebaseFirestore.instance
        .collection("formularios")
        .get()
        .then((querySnapshot) {
      print(querySnapshot.docs.last);
      querySnapshot.docs.last;
    });
  }

  void _onPressed() {
    FirebaseFirestore.instance
        .collection("formularios")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    print('Todo OK!');

    setState(() {
      _guardando = true;
      print(formulario.id);
    });

    if (formulario.id == "") {
      formulario.estado = "Pendiente";
      formulario.observacion = "Pendiente";
      formulario.fechaRespuesta = "Pendiente";
      //Anadir ids de registros de evidencias
      formulario.idVacuna = "Pendiente";
      formulario.idDesparasitacion = "Pendiente";
      formulario.idEvidencia = "Pendiente";
      if (animal.id == '') {
        formulario.idAnimal = 'WCkke2saDQ5AfeJkU6ck';
      } else {
        formulario.idAnimal = animal.id;
      }
      //formulario.idAnimal = "0H05tnjVPjfF1E8DBw0p";
      formulario.fechaIngreso = DateTime.now().toString();
      formulariosProvider.crearFormularioPrin(formulario, datoPersona, context);
    } else {
      //animalProvider.editarAnimal(animal, foto!);
    }
    setState(() {
      _guardando = false;
      // var idd = formulariosProvider
      //     .crearFormularioPrin(formulario, datoPersona)
      //     .toString();
      // print("Hola ID:" + idd);
      //Navigator.pushNamed(context, 'formularioP2', arguments: formulario);
    });

    //mostrarSnackbar('Registro guardado');
  }
}
