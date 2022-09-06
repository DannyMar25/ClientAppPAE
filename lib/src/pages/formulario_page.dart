import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';

import 'package:flutter/material.dart';
import 'dart:ui';

class FormularioAdopcionPage extends StatefulWidget {
  @override
  State<FormularioAdopcionPage> createState() => _FormularioAdopcionPageState();
}

class _FormularioAdopcionPageState extends State<FormularioAdopcionPage> {
  AnimalModel animal = new AnimalModel();
  final formKey = GlobalKey<FormState>();
  final userProvider = new UsuarioProvider();
  final prefs = new PreferenciasUsuario();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    //backgroundColor: Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final email = prefs.email;
    final Object? animData = ModalRoute.of(context)!.settings.arguments;
    if (animData != null) {
      animal = animData as AnimalModel;
      print(animal.id);
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 249),
      appBar: AppBar(
        title: Text('Formulario'),
        backgroundColor: Colors.green,
        actions: [
          email != ''
              ? PopupMenuButton<int>(
                  onSelected: (item) => onSelected(context, item),
                  icon: Icon(Icons.notifications),
                  itemBuilder: (context) => [])
              : SizedBox(),
          PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              icon: Icon(Icons.manage_accounts),
              itemBuilder: (context) => [
                    email == ''
                        ? PopupMenuItem<int>(
                            child: Text("Iniciar sesión"),
                            value: 0,
                          )
                        : PopupMenuItem<int>(
                            child: Text("Cerrar Sesión"),
                            value: 2,
                          ),
                    email == ''
                        ? PopupMenuItem<int>(
                            child: Text("Registrarse"),
                            value: 1,
                          )
                        : PopupMenuItem(child: Text('')),
                  ]),
          // Builder(builder: (BuildContext context) {
          //   return Row(
          //     children: [
          //       email == ''
          //           ? TextButton(
          //               style: ButtonStyle(
          //                 foregroundColor:
          //                     MaterialStateProperty.all<Color>(Colors.white),
          //               ),
          //               onPressed: () async {
          //                 Navigator.pushNamed(context, 'login');
          //               },
          //               child: Text('Iniciar sesión'),
          //             )
          //           : TextButton(
          //               style: ButtonStyle(
          //                 foregroundColor:
          //                     MaterialStateProperty.all<Color>(Colors.white),
          //               ),
          //               onPressed: () async {
          //                 userProvider.signOut();
          //                 Navigator.pushNamed(context, 'home');
          //               },
          //               child: Text('Cerrar sesión'),
          //             ),
          //       email == ''
          //           ? TextButton(
          //               style: ButtonStyle(
          //                 foregroundColor:
          //                     MaterialStateProperty.all<Color>(Colors.white),
          //               ),
          //               onPressed: () async {
          //                 Navigator.pushNamed(context, 'registro');
          //               },
          //               child: Text('Registrarse'),
          //             )
          //           : SizedBox(),
          //     ],
          //   );
          // }),
        ],
      ),
      drawer: MenuWidget(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background(),
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(15.0),
                child: Form(
                    key: formKey,
                    child: Column(children: [
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),

                      Text(
                        'Solicitud de adopción',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      SizedBox(
                        child: Image(
                          image: AssetImage("assets/dog_an9.gif"),
                        ),
                        height: 150.0,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 30.0)),
                      Text(
                        'Por favor llena el siguiente formulario con tus datos personales e información acerca de las condiciones de adopción, nuestros asesores la revisarán y se pondrán en contacto contigo para seguir el proceso.',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 40.0)),
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {
                          //cardB.currentState?.collapse();
                          Navigator.pushNamed(context, 'formularioP1',
                              arguments: animal);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.list_alt,
                              color: Colors.green,
                              size: 100.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'Llenar Formulario',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 40.0)),
                      OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, 'home');
                          },
                          icon: Icon(
                            Icons.photo_album,
                            size: 30,
                            color: Colors.green,
                          ),
                          label: Text(
                            "Volver a la galería",
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          )),
                      //Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      // _HomeBody()
                    ]))),
          )
        ],
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, 'login');
        break;
      case 1:
        Navigator.pushNamed(context, 'registro');
        break;
      case 2:
        userProvider.signOut();
        Navigator.pushNamed(context, 'intro');
    }
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard(
      {Key? key, required this.icon, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: this.color,
          child: Icon(
            this.icon,
            size: 35,
            color: Colors.white,
          ),
          radius: 30,
        ),
        SizedBox(
          height: 10,
        ),
        Text(this.text,
            style: TextStyle(color: this.color, fontSize: 18),
            textAlign: TextAlign.center),
      ],
    );
    return _CardBackground(
      child: column,
    );
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;
  const _CardBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            //margin: EdgeInsets.all(15),
            height: 180,
            decoration: BoxDecoration(
                //color: Color.fromRGBO(62, 66, 107, 0.7),
                color: Color.fromARGB(129, 156, 233, 140),
                borderRadius: BorderRadius.circular(20)),
            child: this.child,
          ),
        ),
      ),
    );
  }

  // Widget contenidoAnt(BuildContext context, AnimalModel animal) {
  //   return Table(
  //     children: [
  //       TableRow(children: [
  //         InkWell(
  //           onTap: () => Navigator.pushReplacementNamed(context, 'formularioP1',
  //               arguments: animal),
  //           child: _SingleCard(
  //             color: Colors.blue,
  //             icon: Icons.person,
  //             text: 'Datos personales',
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () =>
  //               Navigator.pushReplacementNamed(context, 'formularioP2'),
  //           child: _SingleCard(
  //             color: Colors.pinkAccent,
  //             icon: Icons.people,
  //             text: 'Situacion Familiar',
  //           ),
  //         ),
  //       ]),
  //       TableRow(children: [
  //         InkWell(
  //           onTap: () =>
  //               Navigator.pushReplacementNamed(context, 'formularioP3'),
  //           child: _SingleCard(
  //             color: Colors.purple,
  //             icon: Icons.home,
  //             text: 'Domicilio',
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () =>
  //               Navigator.pushReplacementNamed(context, 'formularioP4'),
  //           child: _SingleCard(
  //             color: Colors.green,
  //             icon: Icons.pets,
  //             text: 'Relacion con los animales',
  //           ),
  //         ),
  //       ]),
  //     ],
  //   );
  // }
}
