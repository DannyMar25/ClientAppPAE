import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/card_table.dart';
import 'package:cliente_app_v1/src/widgets/page_title.dart';
import 'package:flutter/material.dart';

class FormularioAdopcionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de adopcion'),
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
        children: [
          //Background
          Background(),

          //Home body
          _HomeBody(),
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
