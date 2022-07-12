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
  bool isDisable = true;
  String campoVacio = 'Por favor, llena este campo';
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
      // backgroundColor: Color.fromARGB(223, 221, 248, 153),
      backgroundColor: Color.fromARGB(223, 211, 212, 207),
      appBar: AppBar(
        title: Text(
          'DATOS PERSONALES',
        ),
        backgroundColor: Colors.green,
      ),
      //backgroundColor: Colors.green,
      drawer: MenuWidget(),
      body: Stack(
        children: [
          // Background(),
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
                            ..strokeWidth = 2
                            ..color = Colors.blueGrey,
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
                            ..strokeWidth = 2
                            ..color = Colors.blueGrey,
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
                            ..strokeWidth = 2
                            ..color = Colors.blueGrey,
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
                            ..strokeWidth = 2
                            ..color = Colors.blueGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      _crearNombreRef(),
                      _crearParentescoRef(),
                      _crearTelefonoRef(),
                      Divider(),
                      // _crearBoton(context),
                      _crearBotonRevisar(context),

                      _crearBoton(context),
                      // _crearBoton1(context)
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
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
          return 'Ingrese solo numeros';
        }
      },
    );
  }

  Widget _crearOcupacion() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: datoPersona.email,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'E-mail',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.email = s;
          formulario.emailClient = s;
        });
      },
    );
  }

  Widget _crearDireccion() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
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
          if (isDisable == true) {
            return Colors.grey;
          } else {
            return Colors.green;
          }
        }),
      ),
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      autofocus: true,
      //onPressed: (_guardando) ? null : _submit,
      onPressed: () {
        if (isDisable == true) {
          return null;
        } else {
          if (formKey.currentState!.validate()) {
            // Si el formulario es válido, queremos mostrar un Snackbar
            //utils.mostrarAlerta(context, 'Datos ingresados correctamente');
            SnackBar(
              content: Text('Informacion ingresada correctamente'),
            );
            _submit();
          } else {
            utils.mostrarAlerta(
                context, 'Asegurate de que todos los campos estan llenos.');
          }
        }
      },
    );
  }

  void _submit() async {
    // if (!formKey.currentState!.validate()) return;
    // formKey.currentState!.save();

    // print('Todo OK!');

    // setState(() {
    //   _guardando = true;
    //   print(formulario.id);
    // });

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
        formulario.idAnimal = animal.id!;
      }
      //formulario.idAnimal = "0H05tnjVPjfF1E8DBw0p";
      formulario.fechaIngreso = DateTime.now().toString();
      formulariosProvider.crearFormularioPrin(formulario, datoPersona, context);
    } else {
      //animalProvider.editarAnimal(animal, foto!);
    }
    // setState(() {
    //   _guardando = false;
    //   // var idd = formulariosProvider
    //   //     .crearFormularioPrin(formulario, datoPersona)
    //   //     .toString();
    //   // print("Hola ID:" + idd);
    //   //Navigator.pushNamed(context, 'formularioP2', arguments: formulario);
    // });

    //mostrarSnackbar('Registro guardado');
  }

  Widget _crearBotonRevisar(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            return Colors.green;
          }),
        ),
        label: Text('Revisar'),
        icon: Icon(Icons.save),
        autofocus: true,
        onPressed: () {
          _mostrarConfirmacion(context);
        });
  }

  Future _mostrarConfirmacion(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmacion'),
            content: Text(
                'Antes de guardar esta seccion, asegurate de haber llenado todos lo campos con la informacion solicitada.'),
            actions: [
              TextButton(
                  child: Text('Lo he revisado'),
                  //onPressed: () => Navigator.of(context).pop(),
                  onPressed: () {
                    setState(() {
                      isDisable = false;
                      Navigator.of(context).pop();
                    });
                  }),
              TextButton(
                  child: Text('Revisar'),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          );
        });
  }
}
