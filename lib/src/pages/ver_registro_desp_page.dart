import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/registro_desparaitaciones_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

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
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    //backgroundColor: Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

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
          title: Text('Lista de desparasitaciones '),
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
                              'Registros',
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
                        ))))
          ],
        ));
  }

  Widget _detalle() {
    return Card(
      child: ListTile(
        title: Text(
          'Aquí encontrarás una lista de todas las desparasitaciones de tu mascota.',
          textAlign: TextAlign.justify,
        ),
      ),
      elevation: 4,
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
                  height: 600,
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
              //Divider(color: Colors.transparent),
              SizedBox(
                height: 245.0,
                width: 620.0,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white)),
                  color: Color.fromARGB(255, 243, 243, 230),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(1.0)),
                      ColoredBox(
                        color: Color.fromARGB(255, 51, 178, 213),
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 15)),
                            SizedBox(
                                height: 50.0,
                                width: 140.0,
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
                                width: 180.0,
                                child: Center(
                                  child: Text(
                                    'Producto',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 50.0,
                            width: 140.0,
                            child: Center(
                              child: Text(
                                desparasitacion.fecha,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 50.0,
                              width: 180.0,
                              child: Center(
                                child: Text(
                                  desparasitacion.nombreProducto,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ],
                      ),
                      ColoredBox(
                        color: Color.fromARGB(255, 51, 178, 213),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 50.0,
                                width: 130.0,
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
                                width: 190.0,
                                child: Center(
                                  child: Text(
                                    'Próxima desparasitación',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 50.0,
                              width: 130.0,
                              child: Center(
                                child: Text(
                                  desparasitacion.pesoActual.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50.0,
                              width: 190.0,
                              child: Center(
                                child: Text(
                                  desparasitacion.fechaProxDesparasitacion,
                                  textAlign: TextAlign.center,
                                ),
                              ))
                        ],
                      )
                    ],
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
                          title: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 50,
                              ),
                              Text('¡Atención!'),
                            ],
                          ),
                          content: Text('¿Estás seguro de borrar el registro?'),
                          actions: [
                            TextButton(
                              child: Text('Si'),
                              onPressed: () {
                                print(desparasitacion.id);
                                formulariosProvider.borrarRegistroDesp(
                                    formularios.id, desparasitacion.id);
                                mostrarOkRegistros(
                                    context,
                                    'El registro ha sido eliminado',
                                    'Información',
                                    'verRegistroDesp',
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
              //Divider(color: Colors.transparent)
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
              Icons.manage_search_sharp,
              color: Colors.green,
            ),
            title: Text('Seguimiento de la mascota'),
            onTap: () => Navigator.pushNamed(context, 'seguimientoMain',
                arguments: {
                  'datosper': datosA,
                  'formulario': formularios,
                  'animal': animal
                }),
          ),
          ExpansionTile(
            title: Text('Vacunas'),
            children: [
              ListTile(
                leading: Icon(
                  Icons.edit_outlined,
                  color: Colors.green,
                ),
                title: Text('Agregar nuevo registro'),
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
                  Icons.list,
                  color: Colors.green,
                ),
                title: Text('Lista de vacunas'),
                onTap: () => Navigator.pushNamed(context, 'verRegistroVacunas',
                    arguments: {
                      'datosper': datosA,
                      'formulario': formularios,
                      'animal': animal
                    }),
              ),
            ],
            leading: Icon(
              Icons.vaccines,
              color: Colors.green,
            ),
          ),
          ExpansionTile(
            title: Text('Desparasitaciones'),
            children: [
              ListTile(
                leading: Icon(Icons.edit_outlined, color: Colors.green),
                title: Text('Agregar nuevo registro'),
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
                leading: Icon(Icons.list, color: Colors.green),
                title: Text('Lista de desparasitaciones'),
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
              Icons.medication_liquid_rounded,
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(Icons.cloud_upload_rounded, color: Colors.green),
            title: Text('Subir evidencia'),
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
