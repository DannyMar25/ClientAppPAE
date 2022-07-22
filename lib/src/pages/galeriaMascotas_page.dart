import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

//import 'package:formvalidation/src/bloc/provider.dart';

class GaleriaMascotasPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  @override
  _GaleriaMascotasPageState createState() => _GaleriaMascotasPageState();
}

class _GaleriaMascotasPageState extends State<GaleriaMascotasPage> {
  final animalesProvider = new AnimalesProvider();
  final userProvider = new UsuarioProvider();
  final prefs = new PreferenciasUsuario();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final formKey = GlobalKey<FormState>();
  String? especie;
  String? sexo;
  String? edad;
  String? tamanio;

  @override
  //bool shouldPop = true;
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);
    final email = prefs.email;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Galería de mascotas'),
            backgroundColor: Colors.green,
            actions: [
              Builder(builder: (BuildContext context) {
                return Row(
                  children: [
                    email == ''
                        ? TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () async {
                              Navigator.pushNamed(context, 'login');
                            },
                            child: Text('Iniciar sesión'),
                          )
                        : TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () async {
                              userProvider.signOut();
                              Navigator.pushNamed(context, 'home');
                            },
                            child: Text('Cerrar sesión'),
                          ),
                    email == ''
                        ? TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () async {
                              Navigator.pushNamed(context, 'registro');
                            },
                            child: Text('Registrarse'),
                          )
                        : SizedBox(),
                  ],
                );
              }),
            ],
          ),
          drawer: MenuWidget(),
          body: Column(
            children: [
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              expand_card(),
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Expanded(child: _crearListado())
              //_crearListado(),
            ],
          )

          //floatingActionButton: _crearBoton(context),
          ),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: animalesProvider.cargarAnimal(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AnimalModel>> snapshot) {
          if (snapshot.hasData) {
            final animales = snapshot.data;
            return GridView.count(
              childAspectRatio: 50 / 100,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(animales!.length, (index) {
                return _crearItem(context, animales[index]);
              }),

              //            return ListView.builder(
              //             itemCount: animales!.length,
              //              itemBuilder: (context, i) => _crearItem(context, animales[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, AnimalModel animal) {
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
                    // title: Text('${animal.nombre} - ${animal.edad}'),
                    subtitle:
                        Text('Especie: ${animal.especie} - ${animal.sexo}'),
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

  Widget _crearItem1(BuildContext context, AnimalModel animal) {
    return Container(
      height: 100.0,
      width: 200.0,
      child: Card(
        color: Color.fromARGB(248, 202, 241, 170),
        elevation: 4.0,
        margin: EdgeInsets.only(bottom: 90.0, left: 5.0, right: 5.0),
        child: InkWell(
          onTap: () =>
              Navigator.pushNamed(context, 'animal', arguments: animal),
          child: Column(
            children: [
              (animal.fotoUrl == "")
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(animal.fotoUrl),
                      placeholder: AssetImage('assets/cat_1.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              //Padding(padding: EdgeInsets.only(bottom: 5.0)),
              ListTile(
                //title: Text('${animal.nombre} - ${animal.edad}'),
                title: Text('${animal.nombre}'),
                subtitle: Text('${animal.especie} - ${animal.sexo}'),
                // onTap: () =>
                //     Navigator.pushNamed(context, 'animal', arguments: animal),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'animal'),
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
        title: Text('Bienvenido a nuestra galería de mascotas!',
            style: TextStyle(fontSize: 17.0)),
        subtitle: Text(
          'Ver más!',
          style: TextStyle(color: Colors.blue, fontSize: 15.0),
        ),
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
                """Hola, a continuación puedes ver nuestra galería de mascotas en adopción. 
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
                  Navigator.pushReplacementNamed(context, 'busqueda');
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
