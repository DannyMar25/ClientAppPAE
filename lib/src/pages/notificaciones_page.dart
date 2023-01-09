import 'package:cliente_app_v1/src/models/usuario_notificacion_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({Key? key}) : super(key: key);

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<NotificationsModel> notificaciones = [];
  List<Future<NotificationsModel>> listaF = [];
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  final prefs = new PreferenciasUsuario();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //showCitas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 12.0)),
                _crearListado()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: usuarioProvider.mostrarNotificaciones(prefs.uid),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationsModel>> snapshot) {
          if (snapshot.hasData) {
            final not = snapshot.data;
            if (not!.length == 0) {
              return Column(children: [
                AlertDialog(
                  title: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 45,
                      ),
                      Text('Aviso!'),
                    ],
                  ),
                  content: Text('No se ha encotrado ninguna notificación.'),
                  actions: [
                    TextButton(
                        child: Text('Ok'),
                        //onPressed: () => Navigator.of(context).pop(),
                        onPressed: () {
                          Navigator.pushNamed(context, 'home');
                        })
                  ],
                )
              ]);
            }
            return Column(
              children: [
                SizedBox(
                  height: 650,
                  child: ListView.builder(
                    itemCount: not.length,
                    itemBuilder: (context, i) => _crearItem(context, not[i]),
                  ),
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, NotificationsModel notificacion) {
    return ListTile(
      title: Column(
        children: [
          //Divider(color: Colors.purple),
          InkWell(
            onTap: () {
              // usuarioProvider.updateView(notificacion, prefs.uid);
              usuarioProvider.editarView(prefs.uid, notificacion.id);
              Navigator.pushNamed(context, 'evidencia');
            },
            child: Card(
              child: Container(
                height: 100,
                color: Colors.white,
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Expanded(
                          child: Image.asset("assets/pet_7.png"),
                          flex: 2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListTile(
                                title: Text(
                                  '${notificacion.notification.title}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle:
                                    Text('${notificacion.notification.body}'),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // TextButton(
                                  //   child: Text("VER INFO"),
                                  //   onPressed: () async {

                                  //   },
                                  // ),
                                  SizedBox(
                                    width: 8,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 8,
                    ),
                  ],
                ),
              ),
              elevation: 8,
              margin: EdgeInsets.all(10),
            ),
          ),
          // Divider(color: Colors.purple)
        ],
      ),
    );
  }
}
