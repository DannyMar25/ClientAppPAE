import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/card_table.dart';
import 'package:cliente_app_v1/src/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class FormularioAdopcionPage extends StatefulWidget {
  @override
  State<FormularioAdopcionPage> createState() => _FormularioAdopcionPageState();
}

class _FormularioAdopcionPageState extends State<FormularioAdopcionPage> {
  AnimalModel animal = new AnimalModel();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Object? animData = ModalRoute.of(context)!.settings.arguments;
    if (animData != null) {
      animal = animData as AnimalModel;
      print(animal.id);
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 249),
      appBar: AppBar(
        title: Text('Formulario de adopcion'),
        backgroundColor: Colors.green,
        actions: [
          Builder(builder: (BuildContext context) {
            return Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, 'login');
                  },
                  child: Text('Iniciar Sesión'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, 'registro');
                  },
                  child: Text('Registrarse'),
                ),
              ],
            );
          }),
        ],
      ),
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
                      Padding(padding: EdgeInsets.only(bottom: 90.0)),
                      Text(
                        'Solicitud de adocpion',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      // SizedBox(
                      //   height: 800,
                      // ),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      Text(
                        'Modulos a llenar para la solicitud de adopcion de una mascota',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      Table(
                        children: [
                          TableRow(children: [
                            InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, 'formularioP1',
                                  arguments: animal),
                              child: _SingleCard(
                                color: Colors.blue,
                                icon: Icons.person,
                                text: 'Datos personales',
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, 'formularioP2'),
                              child: _SingleCard(
                                color: Colors.pinkAccent,
                                icon: Icons.people,
                                text: 'Situacion Familiar',
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, 'formularioP3'),
                              child: _SingleCard(
                                color: Colors.purple,
                                icon: Icons.home,
                                text: 'Domicilio',
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, 'formularioP4'),
                              child: _SingleCard(
                                color: Colors.green,
                                icon: Icons.pets,
                                text: 'Relacion con los animales',
                              ),
                            ),
                          ]),
                        ],
                      )
                    ]))),
          )
          //Background
          //Padding(padding: EdgeInsets.only(bottom: 20.0)),

          //Home body
          // _HomeBody(),
        ],
      ),
      //bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Titulos
          PageTitle(),

          //Card Table
          CardTable(),
        ],
      ),
    );
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
}
