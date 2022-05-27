import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/registro_vacunas_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
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
          title: Text('Registros'),
          backgroundColor: Colors.green,
        ),
        drawer: _menuWidget(),
        body: Stack(children: [
          // Background(),
          SingleChildScrollView(
              child: Container(
                  //color: Colors.lightGreenAccent,
                  padding: new EdgeInsets.only(top: 10.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Registro de vacunas',
                            style: TextStyle(
                              fontSize: 28,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.blueGrey,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          _crearListado()
                        ],
                      ))))
        ]));
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

  Widget _verListado() {
    return Column(
      children: [
        SizedBox(
          height: 800,
          child: ListView.builder(
            itemCount: vacunas.length,
            itemBuilder: (context, i) => _crearItem(context, vacunas[i]),
          ),
        ),
      ],
    );
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
                  height: 700,
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
        title: Column(
          children: [
            Divider(color: Colors.transparent),
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
              columns: [
                DataColumn(label: Text("Fecha")),
                DataColumn(label: Text("Peso(Kg)")),
                DataColumn(label: Text("Proxima vacuna")),
              ],
              rows: [
                DataRow(selected: true, cells: [
                  DataCell(Container(
                    child: Text('${vacuna.fechaConsulta}'),
                    width: 85,
                  )),
                  DataCell(Container(
                    child: Text('${vacuna.pesoActual}'),
                    width: 70,
                  )),
                  DataCell(Container(
                    child: Text('${vacuna.fechaProximaVacuna}'),
                    width: 85,
                  )),
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
              columns: [
                DataColumn(label: Text("Vacuna Laboratorio")),
                DataColumn(label: Text("Veterinario ")),
              ],
              rows: [
                DataRow(selected: true, cells: [
                  DataCell(Container(
                    child: Text('${vacuna.tipoVacuna}'),
                    width: 165,
                  )),
                  DataCell(Container(
                    child: Text('${vacuna.veterinarioResp}'),
                    width: 165,
                  )),
                ]),
              ],
            ),
            Divider(color: Colors.transparent)
          ],
        ),
        //subtitle: Text('${horario}'),
        onTap: () async {
          // datosA = await formulariosProvider.cargarDPId(
          //     formulario.id, formulario.idDatosPersonales);
          // animal = await animalesProvider.cargarAnimalId(formulario.idAnimal);

          // Navigator.pushNamed(context, 'seguimientoMain', arguments: {
          //   'datosper': datosA,
          //   'formulario': formulario,
          //   'animal': animal
          // });
        });
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
