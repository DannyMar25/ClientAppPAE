import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/registro_vacunas_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
import 'package:flutter/material.dart';

class RegistroVacunasPage extends StatefulWidget {
  const RegistroVacunasPage({Key? key}) : super(key: key);

  @override
  State<RegistroVacunasPage> createState() => _RegistroVacunasPageState();
}

class _RegistroVacunasPageState extends State<RegistroVacunasPage> {
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
  RegistroVacunasModel vacunas = new RegistroVacunasModel();
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
        title: Text('Registro de vacunas'),
        backgroundColor: Colors.green,
      ),
      drawer: _menuWidget(),
      body: Stack(
        children: [
          // Background(),
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
                          'Registrar vacunas',
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
                        cardTable(),
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

  Widget _crearFechaConsulta(BuildContext context) {
    return TextFormField(
        textAlign: TextAlign.center,
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
      firstDate: new DateTime(2022),
      lastDate: new DateTime(2025),
      locale: Locale('es'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.green, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.green, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
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
        vacunas.fechaConsulta = _fecha;
      });
    }
  }

  Widget _crearPesoActual() {
    return TextFormField(
      textAlign: TextAlign.center,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          //labelText: 'Peso',
          ),
      onChanged: (s) {
        setState(() {
          vacunas.pesoActual = double.parse(s);
        });
      },
      validator: (value) {
        if (isNumeric(value!)) {
          return null;
        } else {
          return 'Vacio';
        }
      },
    );
  }

  Widget _crearFechaProxima(BuildContext context) {
    return TextFormField(
        textAlign: TextAlign.center,
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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.green, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.green, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
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
        vacunas.fechaProximaVacuna = _fecha1;
      });
    }
  }

  Widget _crearVacuna() {
    return TextFormField(
      //nitialValue: animal.peso.toString(),
      textAlign: TextAlign.center,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(),
      validator: (value) {
        if (value!.length < 3 && value.length > 0) {
          return 'Ingrese el nombre de la vacuna';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      onChanged: (s) {
        setState(() {
          vacunas.tipoVacuna = s;
        });
      },
    );
  }

  Widget _crearVeterinario() {
    return TextFormField(
      textAlign: TextAlign.center,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(),
      validator: (value) {
        if (value!.length < 3 && value.length > 0) {
          return 'Ingrese el nombre de la vacuna';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      onChanged: (s) {
        setState(() {
          vacunas.veterinarioResp = s;
        });
      },
    );
  }

  Widget _detalle() {
    return Card(
      child: ListTile(
        subtitle: Text(
          'En esta sección podrás llevar un registro de las vacunas de tu mascota, este registro será enviado a nuestros colaboradores para poder constatar que tu mascota se encuentre en buenas condiciones de salud.',
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
                content: Text('Información ingresada correctamente.'),
              );

              formulariosProvider.crearRegistroVacuna(
                  vacunas, formularios.id, context);
              mostrarOkRegistros(
                  context,
                  'Registro de vacuna guardado con éxito.',
                  'Información Correcta',
                  'verRegistroVacunas',
                  datosA,
                  formularios,
                  animal);
            } else {
              mostrarAlerta(
                  context, 'Asegúrate de que todos los campos estén llenos.');
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
            // Navigator.pushNamed(context, 'registroVacunas',
            //     arguments: animal);
            // formulariosProvider.crearRegistroVacuna(
            //     vacunas, formularios.id, context);

            Navigator.pushNamed(context, 'verRegistroVacunas', arguments: {
              'datosper': datosA,
              'formulario': formularios,
              'animal': animal
            });
          }),
    ]);
  }

  Widget cardTable() {
    return SizedBox(
      height: 245.0,
      width: 650.0,
      child: Card(
        color: Color.fromARGB(255, 143, 233, 148),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(1.0)),
            ColoredBox(
              color: Color.fromARGB(255, 33, 168, 39),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(top: 15)),
                  SizedBox(
                      height: 50.0,
                      width: 125.0,
                      child: Center(
                        child: Text(
                          'Fecha consulta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(
                      height: 50.0,
                      width: 70.0,
                      child: Center(
                        child: Text(
                          'Peso (Kg.)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(
                      height: 50.0,
                      width: 125.0,
                      child: Center(
                        child: Text(
                          'Próxima vacuna',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                    height: 50.0,
                    width: 125.0,
                    child: _crearFechaConsulta(context)),
                SizedBox(height: 50.0, width: 70.0, child: _crearPesoActual()),
                SizedBox(
                    height: 50.0,
                    width: 125.0,
                    child: _crearFechaProxima(context))
              ],
            ),
            ColoredBox(
              color: Color.fromARGB(255, 33, 168, 39),
              child: Row(
                children: [
                  SizedBox(
                      height: 50.0,
                      width: 160.0,
                      child: Center(
                        child: Text(
                          'Vacuna laboratorio',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(
                      height: 50.0,
                      width: 160.0,
                      child: Center(
                        child: Text(
                          'Veterinario responsable',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(height: 50.0, width: 160.0, child: _crearVacuna()),
                SizedBox(height: 50.0, width: 160.0, child: _crearVeterinario())
              ],
            )
          ],
        ),
        elevation: 8,
        shadowColor: Colors.green,
        margin: EdgeInsets.all(20),
      ),
    );
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
