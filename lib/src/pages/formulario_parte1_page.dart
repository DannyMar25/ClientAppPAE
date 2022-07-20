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
      ['Primaria', 'Secundaria', 'Tercer nivel', 'Posgrado'].toList();
  String? _selection;
  String _fecha = '';
  TextEditingController _inputFieldDateController = new TextEditingController();
  String cedula = '';
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
      // backgroundColor: Color.fromARGB(223, 211, 212, 207),
      backgroundColor: Color.fromARGB(223, 248, 248, 245),
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
                      Divider(
                        color: Colors.transparent,
                      ),
                      _detalle(),
                      Divider(
                        color: Colors.transparent,
                      ),
                      _crearNombre(),
                      _crearCI(),
                      _crearDireccion(),
                      Divider(
                        color: Colors.transparent,
                      ),
                      _crearFechaNacimiento(context),
                      Divider(
                        color: Colors.transparent,
                      ),
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
          // formulario.identificacion = s;
          // datoPersona.cedula = s;
          cedula = s;
        });
      },
    );
  }

  // Widget _crearEdad() {
  //   return TextFormField(
  //     initialValue: datoPersona.fechaNacimiento,
  //     readOnly: false,
  //     //textCapitalization: TextCapitalization.sentences,
  //     keyboardType: TextInputType.numberWithOptions(decimal: true),
  //     decoration: InputDecoration(
  //         labelText: 'Edad',
  //         labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
  //     onSaved: (value) => datoPersona.fechaNacimiento = value!,
  //     validator: (value) {
  //       if (utils.isNumeric(value!)) {
  //         return null;
  //       } else {
  //         return 'Ingrese solo numeros';
  //       }
  //     },
  //   );
  // }
  Widget _crearFechaNacimiento(BuildContext context) {
    return TextFormField(
        controller: _inputFieldDateController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          //counter: Text('Letras ${_nombre.length}'),
          //hintText: 'Ingrese fecha de agendamiento de cita',
          labelText: 'Fecha de nacimiento:',
          //helperText: 'Solo es el nombre',
          suffixIcon: Icon(
            Icons.perm_contact_calendar,
            color: Colors.green,
          ),
          // icon: Icon(
          //   Icons.calendar_today,
          //   color: Colors.green,
          // ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        });
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: DateTime(1910),
      lastDate: new DateTime.now(),
      locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.year.toString() +
            '-' +
            picked.month.toString() +
            '-' +
            picked.day.toString();

        // _fecha = picked.toString();

        //_fecha = DateFormat('EEEE').format(picked);
        _inputFieldDateController.text = _fecha;
        datoPersona.fechaNacimiento = _fecha;
      });
    }
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
            if (cedula.length == 10) {
              //Obtenemos el digito de la region que sonlos dos primeros digitos
              var digito_region = int.parse(cedula.substring(0, 2));

              //Pregunto si la region existe ecuador se divide en 24 regiones
              if (digito_region >= 1 && digito_region <= 24) {
                // Extraigo el ultimo digito
                var ultimo_digito = int.parse(cedula.substring(9, 10));

                //Agrupo todos los pares y los sumo
                var pares = int.parse(cedula.substring(1, 2)) +
                    int.parse(cedula.substring(3, 4)) +
                    int.parse(cedula.substring(5, 6)) +
                    int.parse(cedula.substring(7, 8));

                //Agrupo los impares, los multiplico por un factor de 2, si la resultante es > que 9 le restamos el 9 a la resultante
                var numero1 = int.parse(cedula.substring(0, 1));
                numero1 = (numero1 * 2);
                if (numero1 > 9) {
                  numero1 = (numero1 - 9);
                }

                var numero3 = int.parse(cedula.substring(2, 3));
                numero3 = (numero3 * 2);
                if (numero3 > 9) {
                  numero3 = (numero3 - 9);
                }

                var numero5 = int.parse(cedula.substring(4, 5));
                numero5 = (numero5 * 2);
                if (numero5 > 9) {
                  numero5 = (numero5 - 9);
                }

                var numero7 = int.parse(cedula.substring(6, 7));
                numero7 = (numero7 * 2);
                if (numero7 > 9) {
                  numero7 = (numero7 - 9);
                }

                var numero9 = int.parse(cedula.substring(8, 9));
                numero9 = (numero9 * 2);
                if (numero9 > 9) {
                  numero9 = (numero9 - 9);
                }

                var impares = numero1 + numero3 + numero5 + numero7 + numero9;

                //Suma total
                var suma_total = (pares + impares);

                //extraemos el primero digito
                var primer_digito_suma =
                    (suma_total).toString().substring(0, 1);

                //Obtenemos la decena inmediata
                var decena = (int.parse(primer_digito_suma) + 1) * 10;

                //Obtenemos la resta de la decena inmediata - la suma_total esto nos da el digito validador
                var digito_validador = decena - suma_total;

                //Si el digito validador es = a 10 toma el valor de 0
                if (digito_validador == 10) var digito_validador = 0;

                //Validamos que el digito validador sea igual al de la cedula
                if (digito_validador == ultimo_digito) {
                  print('la cedula:' + cedula + ' es correcta');
                  SnackBar(
                    content: Text('Informacion ingresada correctamente'),
                  );
                  formulario.identificacion = cedula;
                  datoPersona.cedula = cedula;
                  _submit();
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Informacion incorrecta'),
                          content: Text('Numero de cedula incorrecto'),
                          actions: [
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      });
                  print('la cedula:' + cedula + ' es incorrecta');
                }
              } else {
                // imprimimos en consola si la region no pertenece
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Informacion incorrecta'),
                        content: Text('Cedula no pertenece a ninguna region'),
                        actions: [
                          TextButton(
                            child: Text('Ok'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    });
                print('Esta cedula no pertenece a ninguna region');
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Informacion incorrecta'),
                      content: Text('Debe tener al meno 10 digitos'),
                      actions: [
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  });
              //imprimimos en consola si la cedula tiene mas o menos de 10 digitos
              print('Esta cedula tiene mas o menos de 10 Digitos');
            }
            //Codigo anterior
            // SnackBar(
            //   content: Text('Informacion ingresada correctamente'),
            // );
            // _submit();
          } else {
            utils.mostrarAlerta(
                context, 'Asegurate de que todos los campos estan llenos.');
          }
        }
      },
    );
  }

  void _submit() async {
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

  Widget _detalle() {
    return Card(
      child: ListTile(
        title: Text(
          "Formulario: Datos Personales",
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'En este formulario debe ingresar sus datos personales, ten en cuenta que estos son importantes durante el proceso de adopcion.',
          textAlign: TextAlign.justify,
        ),
      ),
      elevation: 8,
      shadowColor: Colors.green,
      margin: EdgeInsets.all(5),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 1)),
    );
  }
}
