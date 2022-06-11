import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

//import 'package:formvalidation/src/bloc/provider.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final animalesProvider = new AnimalesProvider();
  final userProvider = new UsuarioProvider();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);
    final email = prefs.email;
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
      body: _crearListado(),
      //floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: animalesProvider.cargarAnimal(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AnimalModel>> snapshot) {
          if (snapshot.hasData) {
            final animales = snapshot.data;
            return ListView.builder(
              itemCount: animales!.length,
              itemBuilder: (context, i) => _crearItem(context, animales[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, AnimalModel animal) {
    // return Dismissible(
    //   key: UniqueKey(),
    //   background: Container(
    //     color: Colors.red,
    //   ),
    return Card(
      child: Column(
        children: [
          (animal.fotoUrl == "")
              ? Image(image: AssetImage('assets/no-image.png'))
              : FadeInImage(
                  image: NetworkImage(animal.fotoUrl),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  height: 300.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          ListTile(
            title: Text('${animal.nombre} - ${animal.edad}'),
            subtitle: Text('${animal.color} - ${animal.id}'),
            onTap: () =>
                Navigator.pushNamed(context, 'animal', arguments: animal),
          ),
        ],
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
}
