//import 'package:badges/badges.dart';
import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/pages/intro_page.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';

import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

//import 'package:formvalidation/src/bloc/provider.dart';

class ResultadosBusquedaPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  @override
  _ResultadosBusquedaPageState createState() => _ResultadosBusquedaPageState();
}

class _ResultadosBusquedaPageState extends State<ResultadosBusquedaPage> {
  final animalesProvider = new AnimalesProvider();
  final userProvider = new UsuarioProvider();
  final prefs = new PreferenciasUsuario();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final formKey = GlobalKey<FormState>();
  String? especie;
  String? sexo;
  String? etapaVida;
  String? tamanio;
  List<AnimalModel> citasA = [];
  List<Future<AnimalModel>> listaC = [];
  @override
  // void initState() {
  //   super.initState();
  //   showCitas();
  // }

  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);
    //showCitas();
    final email = prefs.email;
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    //if (dat == arg['datosper']) {
    especie = arg['especie'];
    //print(formularios.idDatosPersonales);
    sexo = arg['sexo'];
    etapaVida = arg['etapaVida'];
    tamanio = arg['tamanio'];

    return Scaffold(
        appBar: AppBar(
          title: Text('Resultados'),
          backgroundColor: Colors.green,
          actions: [
            // email != ''
            //     ? Badge(
            //         badgeContent: Text(total.toString(),
            //             style: TextStyle(color: Colors.white)),
            //         position: BadgePosition.topEnd(top: 3, end: 0),
            //         child: IconButton(
            //           //onSelected: (item) => onSelected(context, item),
            //           icon: Icon(
            //             Icons.notifications,
            //           ),
            //           onPressed: () {
            //             Navigator.pushNamed(context, 'notificaciones');
            //           },
            //         ),
            //       )
            //     : SizedBox(),
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
          ],
        ),
        drawer: MenuWidget(),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            expand_card(),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Expanded(
              child: builChild(),
            )
            //_crearListado(),
          ],
        )

        //floatingActionButton: _crearBoton(context),
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => IntroPage()),
            (Route<dynamic> route) => false);
      //Navigator.pushNamed(context, 'intro');
    }
  }

  Widget builChild() {
    if (tamanio == null) {
      return _crearListadoBusqueda3();
    } else {
      return _crearListadoBusqueda();
    }
  }

  Widget _crearListadoBusqueda() {
    return FutureBuilder(
        future: animalesProvider.cargarBusqueda(
            especie!, sexo!, etapaVida!, tamanio!),
        builder:
            (BuildContext context, AsyncSnapshot<List<AnimalModel>> snapshot) {
          if (snapshot.hasData) {
            final animales = snapshot.data;
            if (animales!.length == 0) {
              return Column(children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: AlertDialog(
                    title: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 45,
                        ),
                        Text('Resultado de busqueda'),
                      ],
                    ),
                    content: Text(
                        'No se ha encotrado ninguna mascota con las caracteristicas que buscabas.'),
                    actions: [
                      TextButton(
                          child: Text('Ok'),
                          //onPressed: () => Navigator.of(context).pop(),
                          onPressed: () {
                            Navigator.pushNamed(context, 'home');
                          })
                    ],
                  ),
                )
              ]);
            }
            return GridView.count(
              childAspectRatio: 50 / 100,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(animales.length, (index) {
                return _crearItem1(context, animales[index]);
              }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearListadoBusqueda3() {
    return FutureBuilder(
        future: animalesProvider.cargarBusqueda3(especie!, sexo!, etapaVida!),
        builder:
            (BuildContext context, AsyncSnapshot<List<AnimalModel>> snapshot) {
          if (snapshot.hasData) {
            final animales = snapshot.data;
            if (animales!.length == 0) {
              return Column(children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: AlertDialog(
                    title: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 45,
                        ),
                        Text('Resultado de busqueda!'),
                      ],
                    ),
                    content: Text(
                        'No se ha encotrado ninguna mascota con las caracteristicas que buscabas.'),
                    actions: [
                      TextButton(
                          child: Text('Ok'),
                          //onPressed: () => Navigator.of(context).pop(),
                          onPressed: () {
                            Navigator.pushNamed(context, 'home');
                          })
                    ],
                  ),
                )
              ]);
            }
            return GridView.count(
              childAspectRatio: 50 / 100,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(animales.length, (index) {
                return _crearItem1(context, animales[index]);
              }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem1(BuildContext context, AnimalModel animal) {
    return Expanded(
      child: Container(
        height: 100.0,
        width: 200.0,
        child: Card(
          color: Color.fromARGB(248, 202, 241, 170),
          elevation: 4.0,
          margin: EdgeInsets.only(bottom: 90.0, left: 5.0, right: 5.0),
          child: Flexible(
            fit: FlexFit.loose,
            child: InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, 'animal', arguments: animal),
              child: Column(
                children: [
                  (animal.fotoUrl == "")
                      ? Image(image: AssetImage('assets/no-image.png'))
                      : Expanded(
                          child: FadeInImage(
                            image: NetworkImage(animal.fotoUrl),
                            placeholder: AssetImage('assets/cat_1.gif'),
                            height: 300.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                  //Padding(padding: EdgeInsets.only(bottom: 5.0)),
                  ListTile(
                    title: Text('${animal.nombre}'),
                    subtitle: Text('${animal.especie} - ${animal.sexo}'),
                    // onTap: () =>
                    //     Navigator.pushNamed(context, 'animal', arguments: animal),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget expand_card() {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        baseColor: Colors.green[100],
        shadowColor: Colors.green,
        key: cardA,
        //leading: CircleAvatar(child: Text('A')),
        leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Image(
              image: AssetImage("assets/pet-care.png"),
              fit: BoxFit.fitWidth,
            )),
        title: Text('Bienvenido a nuestra galeria de mascotas!'),
        subtitle: Text('Ver más!'),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                """Hola, a continuacion puedes ver nuestra galeria de mascotas en adopcion. 
Si deseas puedes usar nuestros filtros para realizar una busqueda mas personalizada dependiendo de tus gustos en mascotas.""",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  //cardB.currentState?.collapse();
                  Navigator.pushNamed(context, 'busqueda');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.search),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Buscador'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
