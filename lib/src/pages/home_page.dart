import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

//import 'package:formvalidation/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key? key}) : super(key: key);
  final animalesProvider = new AnimalesProvider();
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
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
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      child: Card(
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
              title: Text('${animal.nombre} - ${animal.edad} meses'),
              subtitle: Text('${animal.color} - ${animal.id}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'animal', arguments: animal),
            ),
          ],
        ),
      ),
    );
  }

//kjdklsf

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'animal'),
    );
  }
}
