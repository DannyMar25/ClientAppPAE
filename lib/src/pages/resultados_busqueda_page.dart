import 'package:cliente_app_v1/src/models/animales_model.dart';
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
  String? edad;
  String? tamanio;

  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);
    final email = prefs.email;
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    //if (dat == arg['datosper']) {
    especie = arg['especie'];
    //print(formularios.idDatosPersonales);
    sexo = arg['sexo'];
    edad = arg['edad'];
    tamanio = arg['tamanio'];

    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Colors.green,
          actions: [
            Builder(builder: (BuildContext context) {
              return Row(
                children: [
                  email == ''
                      ? TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: Text('Iniciar Sesión'),
                        )
                      : SizedBox(),
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
        drawer: MenuWidget(),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            expand_card(),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Expanded(child: _crearListadoBusqueda())
            //_crearListado(),
          ],
        )

        //floatingActionButton: _crearBoton(context),
        );
  }

  Widget _crearListadoBusqueda() {
    return FutureBuilder(
        future:
            animalesProvider.cargarBusqueda(especie!, sexo!, edad!, tamanio!),
        builder:
            (BuildContext context, AsyncSnapshot<List<AnimalModel>> snapshot) {
          if (snapshot.hasData) {
            final animales = snapshot.data;
            return GridView.count(
              childAspectRatio: 50 / 100,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(animales!.length, (index) {
                return _crearItem1(context, animales[index]);
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

  Widget _crearItem1(BuildContext context, AnimalModel animal) {
    return Card(
      color: Color.fromARGB(248, 202, 241, 170),
      elevation: 4.0,
      margin: EdgeInsets.only(bottom: 90.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, 'animal', arguments: animal),
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
              title: Text('${animal.nombre}'),
              subtitle: Text('${animal.especie} - ${animal.sexo}'),
              // onTap: () =>
              //     Navigator.pushNamed(context, 'animal', arguments: animal),
            ),
          ],
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
              // TextButton(
              //   style: flatButtonStyle,
              //   onPressed: () {
              //     cardB.currentState?.expand();
              //   },
              //   child: Column(
              //     children: <Widget>[
              //       Icon(Icons.arrow_downward),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 2.0),
              //       ),
              //       Text('Open'),
              //     ],
              //   ),
              // ),
              TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  //cardB.currentState?.collapse();
                  Navigator.pushReplacementNamed(context, 'busqueda');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.pets),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Buscador'),
                  ],
                ),
              ),
              // TextButton(
              //   style: flatButtonStyle,
              //   onPressed: () {
              //     cardB.currentState?.toggleExpansion();
              //   },
              //   child: Column(
              //     children: <Widget>[
              //       Icon(Icons.swap_vert),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 2.0),
              //       ),
              //       Text('Toggle'),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
