import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/registro_vacunas_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
import 'package:flutter/material.dart';

class VerRegistroVacunasPage extends StatefulWidget {
  const VerRegistroVacunasPage({Key? key}) : super(key: key);

  @override
  State<VerRegistroVacunasPage> createState() => _VerRegistroVacunasPageState();
}

class _VerRegistroVacunasPageState extends State<VerRegistroVacunasPage> {
  final formKey = GlobalKey<FormState>();
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  AnimalModel animal = new AnimalModel();
  FormulariosModel formularios = new FormulariosModel();
  DatosPersonalesModel datosA = new DatosPersonalesModel();

  List<RegistroVacunasModel> vacunas = [];
  List<Future<RegistroVacunasModel>> listaV = [];
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    //backgroundColor: Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

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
        backgroundColor: Color.fromARGB(255, 236, 234, 219),
        appBar: AppBar(
          title: Text('Vacunas'),
          backgroundColor: Colors.green,
        ),
        drawer: _menuWidget(),
        body: SingleChildScrollView(
            child: Flexible(
          fit: FlexFit.loose,
          child: Container(
              //color: Colors.lightGreenAccent,
              padding: new EdgeInsets.only(top: 5.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Registro de vacunas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color.fromARGB(255, 243, 165, 9),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      _detalle(),
                      Divider(
                        color: Colors.transparent,
                      ),
                      _crearListado()
                    ],
                  ))),
        )));
  }

  Widget _detalle() {
    return Card(
      child: ListTile(
        title: Text(
          'Aquí encontrarás una lista de todas las vacunas de tu mascota.',
          textAlign: TextAlign.justify,
        ),
      ),
      elevation: 5,
      shadowColor: Colors.green,
      margin: EdgeInsets.all(5),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 1)),
    );
  }

  showCitas() async {
    listaV = await formulariosProvider.cargarRegistrosVacunas(formularios.id);
    for (var yy in listaV) {
      RegistroVacunasModel form = await yy;
      setState(() {
        vacunas.add(form);
      });
    }
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: formulariosProvider.cargarVacunas(formularios.id),
        builder: (BuildContext context,
            AsyncSnapshot<List<RegistroVacunasModel>> snapshot) {
          if (snapshot.hasData) {
            final vacunas = snapshot.data;
            return Column(
              children: [
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: vacunas!.length,
                    itemBuilder: (context, i) =>
                        _crearItem(context, vacunas[i]),
                  ),
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, RegistroVacunasModel vacuna) {
    return ListTile(
        title: Flexible(
          fit: FlexFit.loose,
          child: Column(
            children: [
              //Divider(color: Colors.transparent),
              SizedBox(
                height: 245.0,
                width: 750.0,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white)),
                  color: Color.fromARGB(255, 243, 243, 230),
                  child: Expanded(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(1.0)),
                        Expanded(
                          child: ColoredBox(
                            color: Color.fromARGB(255, 51, 178, 213),
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 50.0,
                                  width: 125.0,
                                  child: Center(
                                      child: Center(
                                          child: Text(
                                    vacuna.fechaConsulta,
                                    textAlign: TextAlign.center,
                                  )))),
                              SizedBox(
                                  height: 50.0,
                                  width: 70.0,
                                  child: Center(
                                    child: Text(
                                      vacuna.pesoActual.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              SizedBox(
                                  height: 50.0,
                                  width: 125.0,
                                  child: Center(
                                      child: Text(
                                    vacuna.fechaProximaVacuna,
                                    textAlign: TextAlign.center,
                                  )))
                            ],
                          ),
                        ),
                        Expanded(
                          child: ColoredBox(
                            color: Color.fromARGB(255, 51, 178, 213),
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 50.0,
                                  width: 160.0,
                                  child: Center(
                                      child: Text(
                                    vacuna.tipoVacuna,
                                    textAlign: TextAlign.center,
                                  ))),
                              SizedBox(
                                  height: 50.0,
                                  width: 160.0,
                                  child: Center(
                                    child: Text(
                                      vacuna.veterinarioResp,
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  elevation: 8,
                  shadowColor: Color.fromARGB(255, 19, 154, 156),
                  margin: EdgeInsets.all(20),
                ),
              ),
              TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('¡Atención!'),
                          content: Text('¿Estás seguro de borrar el registro?'),
                          actions: [
                            TextButton(
                              child: Text('Si'),
                              onPressed: () {
                                print(vacuna.id);
                                formulariosProvider.borrarRegistroVacunas(
                                    formularios.id, vacuna.id);
                                mostrarOkRegistros(
                                    context,
                                    'El registro ha sido eliminado',
                                    'Información',
                                    'verRegistroVacunas',
                                    datosA,
                                    formularios,
                                    animal);
                              },
                            ),
                            TextButton(
                              child: Text('Cancelar'),
                              //onPressed: () {},
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      });
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.delete_outline,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
        //subtitle: Text('${horario}'),
        onTap: () async {});
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
            title: Text('Subir Evidencia'),
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
