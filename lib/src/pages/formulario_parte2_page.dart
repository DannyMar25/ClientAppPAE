import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/formulario_situacionFam_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:cliente_app_v1/src/utils/utils.dart' as utils;
import 'package:flutter/services.dart';

class FormSituacionFamPage extends StatefulWidget {
  //const formDatPersonalesPage({Key? key}) : super(key: key);

  @override
  _FormSituacionFamPageState createState() => _FormSituacionFamPageState();
}

class _FormSituacionFamPageState extends State<FormSituacionFamPage> {
  //bool _guardando = false;
  bool isDisable = false; //true
  FormulariosModel formulario = new FormulariosModel();
  AnimalModel animal = new AnimalModel();
  SitFamiliarModel sitFamilia = new SitFamiliarModel();
  //DatosPersonalesModel datoPersona = new DatosPersonalesModel();
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  var idFormu;
  var idAnimal;
  String campoVacio = 'Campo vacío';

  //String _fecha = '';
  //TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    idFormu = arg['idFormu'];
    print(idFormu);
    idAnimal = arg['idAnimal'];
    print(idAnimal);
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                  'Si realizas esta acción deberás volver a llenar las secciones nuevamente.'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Estoy de acuerdo'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(223, 248, 248, 245),
        appBar: AppBar(
          title: Text('Formulario de adopción'),
          backgroundColor: Colors.green,
        ),
        drawer: MenuWidget(),
        body: Stack(
          children: [
            //Background(),
            SingleChildScrollView(
              child: Flexible(
                fit: FlexFit.loose,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          //Divider(),
                          // Divider(
                          //   color: Colors.transparent,
                          // ),
                          _detalle(),
                          Divider(
                            color: Colors.transparent,
                          ),

                          Text(
                            'Mencione las personas con las que vive',
                            style: TextStyle(
                              fontSize: 20,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.blueGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Divider(
                            height: 5,
                            color: Colors.transparent,
                          ),
                          Text('Deje en blanco si vive solo/a'),
                          Divider(
                            height: 3,
                            color: Colors.transparent,
                          ),
                          DataTable(
                            sortColumnIndex: 2,
                            sortAscending: false,
                            columnSpacing: 30,
                            columns: [
                              DataColumn(label: Text("Nombre")),
                              DataColumn(label: Text("Edad "), numeric: true),
                              DataColumn(label: Text("Parentesco")),
                            ],
                            rows: [
                              DataRow(selected: true, cells: [
                                DataCell(_crearNombre1()),
                                DataCell(_crearEdad1()),
                                DataCell(_crearParentesco1()),
                              ]),
                              DataRow(cells: [
                                DataCell(_crearNombre2()),
                                DataCell(_crearEdad2()),
                                DataCell(_crearParentesco2()),
                              ]),
                              DataRow(cells: [
                                DataCell(_crearNombre3()),
                                DataCell(_crearEdad3()),
                                DataCell(_crearParentesco3()),
                              ]),
                              DataRow(cells: [
                                DataCell(_crearNombre4()),
                                DataCell(_crearEdad4()),
                                DataCell(_crearParentesco4()),
                              ])
                            ],
                          ),

                          Divider(),
                          Text(
                            '¿Algún familiar espera un bebé?',
                            style: TextStyle(
                              fontSize: 20,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.blueGrey,
                            ),
                          ),
                          Divider(),
                          //Column(
                          // children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Si'),
                              _crearCheckBox1(),
                              SizedBox(
                                width: 10,
                              ),
                              Text('No'), _crearCheckBox2()

                              //_crearFechaParto(context),
                            ],
                          ),
                          // Row(
                          //   children: [Text('No'), _crearCheckBox2()],
                          // ),
                          // ],
                          //),
                          Divider(),
                          Text(
                            '¿Alguien que viva con usted, es alérgico a los animales o sufre de asma?',
                            style: TextStyle(
                              fontSize: 20,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.blueGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Divider(color: Colors.transparent),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Si'),
                                  _crearCheckBox3(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('No'),
                                  _crearCheckBox4()
                                ],
                              ),
                              // Row(
                              //   children: [Text('No'), _crearCheckBox4()],
                              // )
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 10,
                          ),
                          //_crearBotonRevisar(context),
                          _crearBoton(),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearNombre1() {
    return TextFormField(
      initialValue: sitFamilia.nombreFam1,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp("[0-9\-=@,\.;]")),
      ],
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.nombreFam1 = s;
        });
      },
    );
  }

  Widget _crearEdad1() {
    return TextFormField(
      //initialValue: sitFamilia.edadFam1.toString(),
      readOnly: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onSaved: (value) => sitFamilia.edadFam1 = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearParentesco1() {
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
      initialValue: sitFamilia.parentescoFam1,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp("[0-9\-=@,\.;]")),
      ],
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.parentescoFam1 = s;
        });
      },
      // decoration: InputDecoration(
      //   labelText: 'Parentesco',
      //   labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  //2
  Widget _crearNombre2() {
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
      initialValue: sitFamilia.nombreFam2,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp("[0-9\-=@,\.;]")),
      ],
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.nombreFam2 = s;
        });
      },
    );
  }

  Widget _crearEdad2() {
    return TextFormField(
      readOnly: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onSaved: (value) => sitFamilia.edadFam2 = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearParentesco2() {
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
      initialValue: sitFamilia.parentescoFam2,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp("[0-9\-=@,\.;]")),
      ],
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.parentescoFam2 = s;
        });
      },
    );
  }

  //3
  Widget _crearNombre3() {
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
      initialValue: sitFamilia.nombreFam3,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp("[0-9\-=@,\.;]")),
      ],
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.nombreFam3 = s;
        });
      },
    );
  }

  Widget _crearEdad3() {
    return TextFormField(
      //initialValue: sitFamilia.edadFam3.toString(),
      readOnly: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onSaved: (value) => sitFamilia.edadFam3 = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearParentesco3() {
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
      initialValue: sitFamilia.parentescoFam3,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp("[0-9\-=@,\.;]")),
      ],
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.parentescoFam3 = s;
        });
      },
    );
  }

  //4
  Widget _crearNombre4() {
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
      initialValue: sitFamilia.nombreFam4,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp("[0-9\-=@,\.;]")),
      ],
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.nombreFam4 = s;
        });
      },
    );
  }

  Widget _crearEdad4() {
    return TextFormField(
      readOnly: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onSaved: (value) => sitFamilia.edadFam4 = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearParentesco4() {
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
      initialValue: sitFamilia.parentescoFam4,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp("[0-9\-=@,\.;]")),
      ],
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.parentescoFam4 = s;
        });
      },
    );
  }

  Widget _crearCheckBox1() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        if (isChecked1 == true) {
          return null;
        } else {
          setState(() {
            isChecked = value!;
            sitFamilia.esperaBebe = "Si";
          });
        }
      },
    );
  }

  Widget _crearCheckBox2() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked1,
      onChanged: (bool? value) {
        if (isChecked == true) {
          return null;
        } else {
          setState(() {
            isChecked1 = value!;
            sitFamilia.esperaBebe = "No";
          });
        }
      },
    );
  }

  Widget _crearCheckBox3() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked2,
      onChanged: (bool? value) {
        if (isChecked3 == true) {
          return null;
        } else {
          setState(() {
            isChecked2 = value!;
            sitFamilia.alergiaAnimal = "Si";
          });
        }
      },
    );
  }

  Widget _crearCheckBox4() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked3,
      onChanged: (bool? value) {
        if (isChecked2 == true) {
          return null;
        } else {
          setState(() {
            isChecked3 = value!;
            sitFamilia.alergiaAnimal = "No";
          });
        }
      },
    );
  }

  Widget _crearBoton() {
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
          if (isChecked == false && isChecked1 == false) {
            mostrarAlerta(
                context, 'Debe seleccionar una de las dos opciones (Sí o No).');
          } else if (isChecked2 == false && isChecked3 == false) {
            mostrarAlerta(
                context, 'Debe seleccionar una de las dos opciones (Sí o No).');
          } else {
            SnackBar(
              content: Text('Información ingresada correctamente.'),
            );
            _submit();
          }
        }
      },
    );
  }

  void _submit() async {
    print(idFormu);
    formulariosProvider.crearFormSituacionFam(
        sitFamilia, idFormu, context, idAnimal);
  }

  Widget crearBotonRevisar(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            return Colors.green;
          }),
        ),
        label: Text('Revisar'),
        icon: Icon(Icons.reviews),
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
            title: Text('¡Atención!'),
            content: Text(
                'Antes de guardar esta sección, asegúrate de haber llenado todos lo campos con la información solicitada.'),
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
      child: Column(
        children: [
          SizedBox(
            height: 7,
          ),
          ListTile(
            title: Text(
              "Ssección 2: Situación familiar",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'En esta sección debe ingresar información de las personas con las que comparte su hogar.',
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 7,
          ),
        ],
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
