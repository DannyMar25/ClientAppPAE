import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/formulario_situacionFam_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:cliente_app_v1/src/utils/utils.dart' as utils;

class FormSituacionFamPage extends StatefulWidget {
  //const formDatPersonalesPage({Key? key}) : super(key: key);

  @override
  _FormSituacionFamPageState createState() => _FormSituacionFamPageState();
}

class _FormSituacionFamPageState extends State<FormSituacionFamPage> {
  bool _guardando = false;
  bool isDisable = true;
  FormulariosModel formulario = new FormulariosModel();
  SitFamiliarModel sitFamilia = new SitFamiliarModel();
  //DatosPersonalesModel datoPersona = new DatosPersonalesModel();
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  var idFormu;
  String campoVacio = 'Campo vacío';

  String _fecha = '';
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formData = ModalRoute.of(context)!.settings.arguments;
    if (formData != null) {
      //   formulario = formData as FormulariosModel;
      idFormu = formData;
      //   print(formulario.id);
    }
    return Scaffold(
      //backgroundColor: Color.fromARGB(223, 221, 248, 153),
      //backgroundColor: Color.fromARGB(223, 211, 212, 207),
      backgroundColor: Color.fromARGB(223, 248, 248, 245),
      appBar: AppBar(
        title: Text('SITUACIÓN FAMILIAR'),
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
                        Text(
                          'Mencione las personas con las que vive',
                          style: TextStyle(
                            fontSize: 33,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        //Divider(),
                        Divider(
                          color: Colors.transparent,
                        ),
                        _detalle(),
                        Divider(
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
                          'Algun familiar espera un bebe?',
                          style: TextStyle(
                            fontSize: 33,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.blueGrey,
                          ),
                        ),
                        Divider(),
                        //Column(
                        // children: [
                        Row(
                          children: [
                            Text('Si'),
                            _crearCheckBox1(),
                            //_crearFechaParto(context),
                          ],
                        ),
                        Row(
                          children: [Text('No'), _crearCheckBox2()],
                        ),
                        // ],
                        //),
                        Divider(),
                        Text(
                          'Alguien que viva con usted es alérgico a los animales o sufre de asma?',
                          style: TextStyle(
                            fontSize: 33,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Divider(),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Si'),
                                _crearCheckBox3(),
                              ],
                            ),
                            Row(
                              children: [Text('No'), _crearCheckBox4()],
                            )
                          ],
                        ),
                        Divider(),
                        _crearBotonRevisar(context),
                        _crearBoton(),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearNombre1() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: sitFamilia.nombreFam1,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.nombreFam1 = s;
        });
      },
      //decoration: InputDecoration(
      //labelText: 'Nombre Completo',
      //labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearEdad1() {
    return TextFormField(
      initialValue: sitFamilia.edadFam1.toString(),
      readOnly: false,
      //textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      //decoration: InputDecoration(
      //  labelText: 'Edad',
      //  labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onSaved: (value) => sitFamilia.edadFam1 = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearParentesco1() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: sitFamilia.parentescoFam1,
      readOnly: false,
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
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: sitFamilia.nombreFam2,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.nombreFam2 = s;
        });
      },
      //decoration: InputDecoration(
      //labelText: 'Nombre Completo',
      //labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearEdad2() {
    return TextFormField(
      initialValue: sitFamilia.edadFam2.toString(),
      readOnly: false,
      //textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      //decoration: InputDecoration(
      //  labelText: 'Edad',
      //  labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onSaved: (value) => sitFamilia.edadFam2 = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearParentesco2() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: sitFamilia.parentescoFam2,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.parentescoFam2 = s;
        });
      },
      // decoration: InputDecoration(
      //   labelText: 'Parentesco',
      //   labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  //3
  Widget _crearNombre3() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: sitFamilia.nombreFam3,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.nombreFam3 = s;
        });
      },
      //decoration: InputDecoration(
      //labelText: 'Nombre Completo',
      //labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearEdad3() {
    return TextFormField(
      initialValue: sitFamilia.edadFam3.toString(),
      readOnly: false,
      //textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      //decoration: InputDecoration(
      //  labelText: 'Edad',
      //  labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onSaved: (value) => sitFamilia.edadFam3 = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearParentesco3() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: sitFamilia.parentescoFam3,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.parentescoFam3 = s;
        });
      },
      // decoration: InputDecoration(
      //   labelText: 'Parentesco',
      //   labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  //4
  Widget _crearNombre4() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: sitFamilia.nombreFam4,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.nombreFam4 = s;
        });
      },
      //decoration: InputDecoration(
      //labelText: 'Nombre Completo',
      //labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearEdad4() {
    return TextFormField(
      initialValue: sitFamilia.edadFam4.toString(),
      readOnly: false,
      //textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      //decoration: InputDecoration(
      //  labelText: 'Edad',
      //  labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onSaved: (value) => sitFamilia.edadFam4 = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearParentesco4() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: sitFamilia.parentescoFam4,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          sitFamilia.parentescoFam4 = s;
        });
      },
      // decoration: InputDecoration(
      //   labelText: 'Parentesco',
      //   labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
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
        setState(() {
          isChecked = value!;
          sitFamilia.esperaBebe = "Si";
        });
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
        setState(() {
          isChecked1 = value!;
          sitFamilia.esperaBebe = "No";
        });
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
        setState(() {
          isChecked2 = value!;
          sitFamilia.alergiaAnimal = "Si";
        });
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
        setState(() {
          isChecked3 = value!;
          sitFamilia.alergiaAnimal = "No";
        });
      },
    );
  }

  Widget _crearFechaParto(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //hintText: 'Ingrese fecha aproximada',
        labelText: 'Fecha aproximada de parto',
        suffixIcon: Icon(Icons.perm_contact_calendar),
        icon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
      //onSaved: (value) => horarios.dia = _inputFieldDateController.toString(),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2021),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.year.toString() +
            '-' +
            picked.month.toString() +
            '-' +
            picked.day.toString();
        //_fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
        //horarios.dia = picked.toString();
      });
    }
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
          if (formKey.currentState!.validate()) {
            // Si el formulario es válido, queremos mostrar un Snackbar
            //utils.mostrarAlerta(context, 'Datos ingresados correctamente');
            SnackBar(
              content: Text('Información ingresada correctamente'),
            );
            _submit();
          } else {
            utils.mostrarAlerta(
                context, 'Asegurate de que todos los campos están llenos.');
          }
        }
      },
    );
  }

  void _submit() async {
    // if (!formKey.currentState!.validate()) return;
    // formKey.currentState!.save();

    // //print('Todo OK!');

    // setState(() {
    //   _guardando = true;
    // });
//Sentencia If agregada recientemente
    //if (idFormu != null) {
    print(idFormu);
    formulariosProvider.crearFormSituacionFam(sitFamilia, idFormu, context);
    // } else {
    //animalProvider.editarAnimal(animal, foto!);
    //print(idFormu);
    // print("Debe llenar la parte 1 para poder continuar");
    //}
    //setState(() {
    //  _guardando = false;
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
          "Formulario: Situacion familiar",
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'En este formulario debe ingresar información de las personas con las que vive.',
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
