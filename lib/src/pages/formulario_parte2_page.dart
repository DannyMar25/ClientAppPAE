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
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  String _fecha = '';
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SITUACION FAMILIAR'),
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
                        'Mencione las personas con las que vive',
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
                      DataTable(
                        sortColumnIndex: 2,
                        sortAscending: false,
                        columns: [
                          DataColumn(label: Text("Nombre")),
                          DataColumn(label: Text("Edad "), numeric: true),
                          DataColumn(label: Text("Parentesco")),
                        ],
                        rows: [
                          DataRow(selected: true, cells: [
                            DataCell(_crearNombre()),
                            DataCell(_crearEdad()),
                            DataCell(_crearParentesco()),
                          ]),
                          DataRow(cells: [
                            DataCell(_crearNombre()),
                            DataCell(_crearEdad()),
                            DataCell(_crearParentesco()),
                          ]),
                          DataRow(cells: [
                            DataCell(_crearNombre()),
                            DataCell(_crearEdad()),
                            DataCell(_crearParentesco()),
                          ]),
                          DataRow(cells: [
                            DataCell(_crearNombre()),
                            DataCell(_crearEdad()),
                            DataCell(_crearParentesco()),
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
                            ..color = Colors.orange[100]!,
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
                        'Alguien que viva con usted es alergico a los animales o sufre de asma?',
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
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      //decoration: InputDecoration(
      //labelText: 'Nombre Completo',
      //labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearEdad() {
    return TextFormField(
      //initialValue: animal.edad.toString(),
      readOnly: false,
      //textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      //decoration: InputDecoration(
      //  labelText: 'Edad',
      //  labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      // //onSaved: (value) => animal.edad = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearParentesco() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
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
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
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
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked1,
      onChanged: (bool? value) {
        setState(() {
          isChecked1 = value!;
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
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked2,
      onChanged: (bool? value) {
        setState(() {
          isChecked2 = value!;
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
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked3,
      onChanged: (bool? value) {
        setState(() {
          isChecked3 = value!;
        });
      },
    );
  }

  Widget _crearFechaParto(BuildContext context) {
    return TextFormField(
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
}
