import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/registro_desparaitaciones_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:flutter/material.dart';

class VerRegistroDespPage extends StatefulWidget {
  const VerRegistroDespPage({Key? key}) : super(key: key);

  @override
  State<VerRegistroDespPage> createState() => _VerRegistroDespPageState();
}

class _VerRegistroDespPageState extends State<VerRegistroDespPage> {
  final formKey = GlobalKey<FormState>();
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  AnimalModel animal = new AnimalModel();
  FormulariosModel formularios = new FormulariosModel();
  DatosPersonalesModel datosA = new DatosPersonalesModel();

  List<RegistroDesparasitacionModel> desparasitaciones = [];
  List<Future<RegistroDesparasitacionModel>> listaD = [];

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
          title: Text('Registros de desparasitación'),
          backgroundColor: Colors.green,
        ),
        drawer: _menuWidget(),
        body: Stack(
          children: [
            //Background(),
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
                              'Registros de desparasitación',
                              style: TextStyle(
                                fontSize: 28,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.blueGrey,
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
                        ))))
          ],
        ));
  }

  Widget _detalle() {
    return Card(
      child: ListTile(
        // title: Text(
        //   "Registro de vacunas",
        //   style: TextStyle(
        //       color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
        // ),
        subtitle: Text(
          'Aqui encontraras una lista de todas las desparacitaciones de tu mascota.',
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

  Widget _crearListado() {
    return FutureBuilder(
        future: formulariosProvider.cargarRegDesp(formularios.id),
        builder: (BuildContext context,
            AsyncSnapshot<List<RegistroDesparasitacionModel>> snapshot) {
          if (snapshot.hasData) {
            final desp = snapshot.data;
            return Column(
              children: [
                SizedBox(
                  height: 700,
                  child: ListView.builder(
                    itemCount: desp!.length,
                    itemBuilder: (context, i) => _crearItem(context, desp[i]),
                  ),
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, RegistroDesparasitacionModel desparasitacion) {
    return ListTile(
        title: Flexible(
          fit: FlexFit.loose,
          child: Column(
            children: [
              Divider(color: Colors.transparent),
              DataTable(
                columnSpacing: 35,
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
                  DataColumn(label: Text("Fecha consulta")),
                  DataColumn(label: Text("Producto")),
                ],
                rows: [
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      child: Text('${desparasitacion.fecha}'),
                      width: 140,
                    )),
                    //DataCell(_crearPesoActual()),
                    DataCell(Container(
                      child: Text('${desparasitacion.nombreProducto}'),
                      width: 140,
                    )),
                  ]),
                ],
              ),
              DataTable(
                columnSpacing: 35,
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
                  DataColumn(label: Text("Peso(Kg)")),
                  DataColumn(label: Text("Proxima desparacitacion")),
                ],
                rows: [
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      child: Text('${desparasitacion.pesoActual}'),
                      width: 115,
                    )),
                    DataCell(Container(
                      child:
                          Text('${desparasitacion.fechaProxDesparasitacion}'),
                      width: 100,
                    )),
                  ]),
                ],
              ),
              Divider(color: Colors.transparent)
            ],
          ),
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
