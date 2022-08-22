import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
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
    super.initState();
  }

  AnimalModel animal = new AnimalModel();
  @override
  Widget build(BuildContext context) {
    final Object? animData = ModalRoute.of(context)!.settings.arguments;
    if (animData != null) {
      animal = animData as AnimalModel;
      print(animal.id);
    }

    return Scaffold(
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
                        'Teléfonos de contacto',
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
        if (value!.length < 3 && value.length > 0) {
          return 'Ingrese su nombre completo';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
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
        if (value!.length < 10 && value.length > 0) {
          return 'Ingrese número de cédula válido';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      initialValue: datoPersona.cedula,
      readOnly: false,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Cédula',
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

  Widget _crearFechaNacimiento(BuildContext context) {
    return TextFormField(
        controller: _inputFieldDateController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Fecha de nacimiento:',
          //helperText: 'Solo es el nombre',
          suffixIcon: Icon(
            Icons.perm_contact_calendar,
            color: Colors.green,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return campoVacio;
          } else {
            return null;
          }
        },
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
        if (value!.length < 3 && value.length > 0) {
          return 'Ingrese una ocupación';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      initialValue: datoPersona.ocupacion,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Ocupación',
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
      validator: (value) => utils.validarEmail(value),
      initialValue: datoPersona.email,
      readOnly: false,
      keyboardType: TextInputType.emailAddress,
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
        if (value!.length < 3 && value.length > 0) {
          return 'Ingrese su dirección';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      initialValue: datoPersona.direccion,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Dirección exacta donde estará la mascota',
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
          'Seleccione nivel de instrucción:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          width: 138.0,
          child: DropdownButtonFormField<String>(
              //hint: Text(animal.tamanio.toString()),
              value: _selection,
              items: dropdownMenuOptions,
              validator: (value) =>
                  value == null ? 'Seleccione una opción' : null,
              onChanged: (s) {
                setState(() {
                  _selection = s;

                  datoPersona.nivelInst = s!;
                  //animal.tamanio = s!;
                });
              }),
        ),
      ],
    );
  }

  Widget _crearTelfDomicilio() {
    return TextFormField(
      validator: (value) {
        if (value!.length < 9 && value.length > 0 || value.length > 10) {
          return 'Ingrese un número de teléfono válido';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      initialValue: datoPersona.telfDomi,
      readOnly: false,
      keyboardType: TextInputType.phone,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Teléfono de domicilio',
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
        if (value!.length < 10 && value.length > 0 || value.length > 10) {
          return 'Ingrese un número de teléfono válido';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      initialValue: datoPersona.telfCel,
      readOnly: false,
      keyboardType: TextInputType.phone,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Teléfono celular',
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
        if (value!.length < 9 && value.length > 0 || value.length > 10) {
          return 'Ingrese un número de teléfono válido';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      initialValue: datoPersona.telfTrab,
      readOnly: false,
      keyboardType: TextInputType.phone,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Teléfono de trabajo',
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
        if (value!.length < 3 && value.length > 0) {
          return 'Ingrese el nombre';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
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
        if (value!.length < 3 && value.length > 0) {
          return 'Ingrese el parentesco';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
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
        if (value!.length < 9 && value.length > 0 || value.length > 10) {
          return 'Ingrese un número de teléfono válido';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      initialValue: datoPersona.telfRef,
      readOnly: false,
      keyboardType: TextInputType.phone,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Teléfono',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          datoPersona.telfRef = s;
        });
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    bool cedulaCorrecta = false;
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
            //utils.validadorDeCedula(cedula);
            if (cedula.length == 10) // ConstantesApp.LongitudCedula
            {
              int tercerDigito = int.parse(cedula.substring(2, 3));
              if (tercerDigito < 6) {
                List<int> coefValCedula = [2, 1, 2, 1, 2, 1, 2, 1, 2];
                int verificador = int.parse(cedula.substring(9, 10));
                int suma = 0;
                int digito = 0;
                for (int i = 0; i < (cedula.length - 1); i++) {
                  digito =
                      int.parse(cedula.substring(i, i + 1)) * coefValCedula[i];
                  suma += ((digito % 10) + (digito / 10)).toInt();
                }
                if ((suma % 10 == 0) && (suma % 10 == verificador)) {
                  cedulaCorrecta = true;
                  //print('La cedula es correcta');
                  print('La cédula:' + cedula + ' es correcta');
                  SnackBar(
                    content: Text('Información ingresada correctamente'),
                  );
                  formulario.identificacion = cedula;
                  datoPersona.cedula = cedula;
                  _submit();
                } else if ((10 - (suma % 10)) == verificador) {
                  cedulaCorrecta = true;
                  //print('La cedula es correcta');
                  print('La cédula:' + cedula + ' es correcta');
                  SnackBar(
                    content: Text('Información ingresada correctamente'),
                  );
                  formulario.identificacion = cedula;
                  datoPersona.cedula = cedula;
                  _submit();
                } else {
                  cedulaCorrecta = false;
                  //print('La cedula es incorrecta');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Información incorrecta'),
                          content: Text('Número de cédula incorrecto'),
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
                cedulaCorrecta = false;
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Información incorrecta'),
                        content: Text('Número de cédula incorrecto'),
                        actions: [
                          TextButton(
                            child: Text('Ok'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    });
                print('la cedula:' + cedula + ' es incorrecta');
                //print('La cedula es incorrecta');
              }
            } else {
              cedulaCorrecta = false;
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Información incorrecta'),
                      content: Text('Número de cédula incorrecto'),
                      actions: [
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  });
              print('la cedula:' + cedula + ' es incorrecta');
              //print('La cedula es incorrecta');
            }
            if (!cedulaCorrecta) {
              //print("La Cédula ingresada es Incorrecta");
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Información incorrecta'),
                      content: Text('Número de cédula incorrecto'),
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
            //return cedulaCorrecta;

          } else {
            utils.mostrarAlerta(context,
                'Asegurate de que los datos hayan sido ingresados correctamente y que no existan campos vacíos.');
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

      formulariosProvider.crearFormularioPrin(
          formulario, datoPersona, context, animal.id.toString());
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
            title: Text('Atención'),
            content: Text(
                'Antes de guardar esta sección, asegurate de haber llenado todos lo campos con la información solicitada.'),
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
