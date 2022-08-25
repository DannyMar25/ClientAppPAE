import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/registro_desparaitaciones_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
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
  String campoVacio = 'Campo vacío';

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
      //backgroundColor: Color.fromARGB(223, 211, 212, 207),
      backgroundColor: Color.fromARGB(223, 248, 248, 245),
      appBar: AppBar(
        title: Text('Registro de desparasitación'),
        backgroundColor: Colors.green,
      ),
      drawer: _menuWidget(),
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
                          'Registrar desparacitaciones',
                          style: TextStyle(
                            fontSize: 33,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
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
                          columnSpacing: 15,
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
                                label: Text("Fecha consulta             ")),
                            DataColumn(
                                label:
                                    Text("            Producto              ")),
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
                          columnSpacing: 20,
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
                          //dataRowHeight: 25,
                          columns: [
                            DataColumn(
                                label: Text("Peso(Kg)                "),
                                numeric: true),
                            DataColumn(label: Text("Próxima desparacitación")),
                          ],
                          rows: [
                            DataRow(selected: true, cells: [
                              DataCell(_crearPesoActual()),
                              DataCell(Container(
                                width: 110,
                                child: _crearFechaProxima(context),
                              )),
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
          ),
        ],
      ),
    );
  }

  Widget _detalle() {
    return Card(
      child: ListTile(
        subtitle: Text(
          'En esta sección podras llevar un registro de las desparacitaciones de tu mascota, este registro sera enviado a nuestros colaboradores para poder constatar que tu mascota se encuentre en buenas condiciones de salud.',
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

  Widget _crearFechaConsulta(BuildContext context) {
    return TextFormField(
        controller: _inputFieldDateController,
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          //labelText: 'Peso',
          ),
      onChanged: (s) {
        setState(() {
          desparasitacion.pesoActual = double.parse(s);
        });
      },
      validator: (value) {
        if (isNumeric(value!)) {
          return null;
        } else {
          return 'Vacío';
        }
      },
    );
  }

  Widget _crearFechaProxima(BuildContext context) {
    return TextFormField(
        controller: _inputFieldDateController1,
        validator: (value) {
          if (value!.isEmpty) {
            return campoVacio;
          } else {
            return null;
          }
        },
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
            (picked.month < 10
                ? '0' + picked.month.toString()
                : picked.month.toString()) +
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
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(),
      validator: (value) {
        if (value!.length < 3 && value.length > 0) {
          return 'Inválido';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
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
            if (formKey.currentState!.validate()) {
              // Si el formulario es válido, queremos mostrar un Snackbar
              SnackBar(
                content: Text('Información ingresada correctamente'),
              );

              formulariosProvider.crearRegistroDesparasitacion(
                  desparasitacion, formularios.id, context);

              mostrarOkRegistros(
                  context,
                  'Registro de desparasitación guardado con éxito.',
                  'Información Correcta',
                  'verRegistroDesp',
                  datosA,
                  formularios,
                  animal);
            } else {
              mostrarAlerta(
                  context, 'Asegurate de que todos los campos están llenos.');
            }
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
            Navigator.pushNamed(context, 'verRegistroDesp', arguments: {
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
            title: Text('Seguimiento Principal'),
            onTap: () => Navigator.pushNamed(context, 'seguimientoMain',
                arguments: {
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
                  Navigator.pushNamed(context, 'registroVacunas', arguments: {
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
                onTap: () => Navigator.pushNamed(context, 'verRegistroVacunas',
                    arguments: {
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
            title: Text('Registro de Desparasitación'),
            children: [
              ListTile(
                leading: Icon(Icons.settings, color: Colors.green),
                title: Text('Registro Desparasitación'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, 'registroDesp', arguments: {
                    'datosper': datosA,
                    'formulario': formularios,
                    'animal': animal
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.check, color: Colors.green),
                title: Text('Ver Registro Desparasitación'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, 'verRegistroDesp', arguments: {
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
              Navigator.pushNamed(context, 'demoArchivos', arguments: {
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
