import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/registro_desparaitaciones_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:flutter/material.dart';

class RegistroDespPage extends StatefulWidget {
  const RegistroDespPage({Key? key}) : super(key: key);

  @override
  State<RegistroDespPage> createState() => _RegistroDespPageState();
}

class _RegistroDespPageState extends State<RegistroDespPage> {
  final formKey = GlobalKey<FormState>();

  String _fecha = '';
  TextEditingController _inputFieldDateController = new TextEditingController();
  String _fecha1 = '';
  TextEditingController _inputFieldDateController1 =
      new TextEditingController();

  FormulariosProvider formulariosProvider = new FormulariosProvider();
  AnimalModel animal = new AnimalModel();
  FormulariosModel formularios = new FormulariosModel();
  DatosPersonalesModel datosA = new DatosPersonalesModel();
  RegistroDesparasitacionModel desparasitacion =
      new RegistroDesparasitacionModel();

  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    datosA = arg['datosper'] as DatosPersonalesModel;
    formularios = arg['formulario'] as FormulariosModel;
    animal = arg['animal'] as AnimalModel;
    return Scaffold(
      backgroundColor: Color.fromARGB(223, 211, 212, 207),
      appBar: AppBar(
        title: Text('Registro de desparasitacion'),
        backgroundColor: Colors.green,
      ),
      drawer: _menuWidget(),
      body: Stack(
        children: [
          //Background(),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Registro de desparacitaciones',
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
                      DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromARGB(255, 120, 110, 148),
                        ),
                        dataRowColor: MaterialStateColor.resolveWith(
                            (states) => Color.fromARGB(255, 146, 155, 185)),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        sortColumnIndex: 1,
                        sortAscending: false,
                        columns: [
                          DataColumn(
                              label:
                                  Text("Fecha consulta                      ")),
                          DataColumn(label: Text("Producto    ")),
                        ],
                        rows: [
                          DataRow(selected: true, cells: [
                            DataCell(_crearFechaConsulta(context)),
                            //DataCell(_crearPesoActual()),
                            DataCell(_crearProducto()),
                          ]),
                        ],
                      ),
                      DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromARGB(255, 120, 110, 148),
                        ),
                        dataRowColor: MaterialStateColor.resolveWith(
                            (states) => Color.fromARGB(255, 146, 155, 185)),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        sortColumnIndex: 1,
                        sortAscending: false,
                        columns: [
                          DataColumn(
                              label: Text("        Peso(Kg)"), numeric: true),
                          DataColumn(label: Text("Proxima desparacitacion")),
                        ],
                        rows: [
                          DataRow(selected: true, cells: [
                            DataCell(_crearPesoActual()),
                            DataCell(_crearFechaProxima(context)),
                          ]),
                        ],
                      ),
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

  Widget _crearFechaConsulta(BuildContext context) {
    return TextFormField(
        controller: _inputFieldDateController,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        });
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2025),
      locale: Locale('es'),
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
        desparasitacion.fecha = _fecha;
      });
    }
  }

  Widget _crearPesoActual() {
    return TextFormField(
      //nitialValue: animal.peso.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          //labelText: 'Peso',
          ),
      onChanged: (s) {
        setState(() {
          desparasitacion.pesoActual = double.parse(s);
        });
      },
    );
  }

  Widget _crearFechaProxima(BuildContext context) {
    return TextFormField(
        controller: _inputFieldDateController1,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate1(context);
        });
  }

  _selectDate1(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _fecha1 = picked.year.toString() +
            '-' +
            picked.month.toString() +
            '-' +
            picked.day.toString();

        // _fecha = picked.toString();
        //_fecha = DateFormat('EEEE').format(picked);
        _inputFieldDateController1.text = _fecha1;
        desparasitacion.fechaProxDesparasitacion = _fecha1;
      });
    }
  }

  Widget _crearProducto() {
    return TextFormField(
      //nitialValue: animal.peso.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          // labelText: 'Vacuna',
          ),
      onChanged: (s) {
        setState(() {
          desparasitacion.nombreProducto = s;
        });
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton.icon(
          style: ButtonStyle(
            //padding: new EdgeInsets.only(top: 5),
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return Colors.green[500];
            }),
          ),
          label: Text('Guardar'),
          icon: Icon(Icons.save),
          autofocus: true,
          onPressed: () {
            // Navigator.pushNamed(context, 'registroVacunas',
            //     arguments: animal);
            formulariosProvider.crearRegistroDesparasitacion(
                desparasitacion, formularios.id, context);
            Navigator.pushReplacementNamed(context, 'seguimientoMain',
                arguments: {
                  'datosper': datosA,
                  'formulario': formularios,
                  'animal': animal
                });
          }),
    ]);
  }

  Widget _crearBoton1(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton.icon(
          style: ButtonStyle(
            //padding: new EdgeInsets.only(top: 5),
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return Colors.green[500];
            }),
          ),
          label: Text('Ver registros'),
          icon: Icon(Icons.save),
          autofocus: true,
          onPressed: () {
            // Navigator.pushNamed(context, 'registroVacunas',
            //     arguments: animal);
            // formulariosProvider.crearRegistroVacuna(
            //     vacunas, formularios.id, context);

            Navigator.pushReplacementNamed(context, 'verRegistroDesp',
                arguments: {
                  'datosper': datosA,
                  'formulario': formularios,
                  'animal': animal
                });
          }),
    ]);
  }

  Widget _menuWidget() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pet-care.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.pages,
              color: Colors.green,
            ),
            title: Text('Seguimiento Home'),
            onTap: () => Navigator.pushReplacementNamed(
                context, 'seguimientoMain', arguments: {
              'datosper': datosA,
              'formulario': formularios,
              'animal': animal
            }),
          ),
          ExpansionTile(
            title: Text('Registro de Vacunas'),
            children: [
              ListTile(
                leading: Icon(
                  Icons.meeting_room,
                  color: Colors.green,
                ),
                title: Text('Realizar registro'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'registroVacunas',
                      arguments: {
                        'datosper': datosA,
                        'formulario': formularios,
                        'animal': animal
                      });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                title: Text('Ver registros'),
                onTap: () => Navigator.pushReplacementNamed(
                    context, 'verRegistroVacunas', arguments: {
                  'datosper': datosA,
                  'formulario': formularios,
                  'animal': animal
                }),
              ),
            ],
            leading: Icon(
              Icons.assignment,
              color: Colors.green,
            ),
          ),
          ExpansionTile(
            title: Text('Registro de Desparasitacion'),
            children: [
              ListTile(
                leading: Icon(Icons.settings, color: Colors.green),
                title: Text('Registro Desparasitacion'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'registroDesp',
                      arguments: {
                        'datosper': datosA,
                        'formulario': formularios,
                        'animal': animal
                      });
                },
              ),
              ListTile(
                leading: Icon(Icons.check, color: Colors.green),
                title: Text('Ver Registro Desparasitacion'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'verRegistroDesp',
                      arguments: {
                        'datosper': datosA,
                        'formulario': formularios,
                        'animal': animal
                      });
                },
              ),
            ],
            leading: Icon(
              Icons.assignment,
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.green),
            title: Text('Cargar Evidencia'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'demoArchivos',
                  arguments: {
                    'datosper': datosA,
                    'formulario': formularios,
                    'animal': animal
                  });
            },
          ),
        ],
      ),
    );
  }
}
