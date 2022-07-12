import 'package:flutter/material.dart';

class BusquedaPage extends StatefulWidget {
  const BusquedaPage({Key? key}) : super(key: key);

  @override
  State<BusquedaPage> createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  final formKey = GlobalKey<FormState>();
  final List<String> _especie = ['Canina', 'Felina'].toList();
  String? _selection;
  final List<String> _sexo = ['Macho', 'Hembra'].toList();
  String? _selection1;
  final List<String> _edad = [
    'Cachorro (0 a 6 meses)',
    'Joven (6 meses a 2 años)',
    'Adulto (2 a 6 años)',
    'Anciano (7 a 11 años)',
    'Geriátrico (mayor a 12 años)',
  ].toList();
  String? _selection2;
  final List<String> _tamanio = ['Pequeño', 'Mediano', 'Grande'].toList();
  String? _selection3;

  bool isChecked1 = false;
  bool isChecked2 = false;
  String? _selection4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
        backgroundColor: Colors.green,
        title: Text('Busqueda de mascotas'),
      ),
      body: Stack(
        children: [
          //Background(),
          SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.all(15.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      //Padding(padding: EdgeInsets.only(top: 1.0)),
                      SizedBox(
                        height: 170,
                        child: Image(
                          image: AssetImage("assets/dog_an6.gif"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text('Buscador',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                          )),
                      Text(
                        'Selecciona la o las categorias de tu gusto y te mostraremos los resultados',
                        style: TextStyle(fontSize: 15),
                      ),
                      //Divider(),
                      //Text('Especie:'),
                      Divider(),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 120.0)),
                          SizedBox(
                              height: 80,
                              child: Image(
                                  image: AssetImage("assets/dog_an1.gif"))),
                          Padding(padding: EdgeInsets.only(left: 60.0)),
                          SizedBox(
                              height: 80,
                              child: Image(
                                  image: AssetImage("assets/cat_im2.jpg")))
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15.0)),
                      _seleccionarEspecie(),
                      //Divider(),
                      //Text('Sexo:'),
                      //Divider(),
                      Padding(padding: EdgeInsets.only(bottom: 15.0)),
                      _seleccionarSexo(),
                      //Divider(),
                      //Text('Edad:'),
                      Padding(padding: EdgeInsets.only(bottom: 15.0)),
                      _seleccionarEdad(),
                      // Divider(),
                      //Text('Tamaño:'),
                      //Divider(),
                      Padding(padding: EdgeInsets.only(bottom: 15.0)),
                      _seleccionarTamanio(),
                      Padding(padding: EdgeInsets.only(bottom: 40.0)),
                      _crearBoton()
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _crearCheckBox1() {
  //   Color getColor(Set<MaterialState> states) {
  //     const Set<MaterialState> interactiveStates = <MaterialState>{
  //       MaterialState.pressed,
  //       MaterialState.hovered,
  //       MaterialState.focused,
  //     };
  //     if (states.any(interactiveStates.contains)) {
  //       return Colors.blue;
  //     }
  //     return Colors.blue;
  //   }

  //   return Checkbox(
  //     checkColor: Colors.white,
  //     fillColor: MaterialStateProperty.resolveWith(getColor),
  //     value: isChecked1,
  //     onChanged: (bool? value) {
  //       setState(() {
  //         isChecked1 = value!;
  //         _selection4 = 'Canina';
  //       });
  //     },
  //   );
  // }

  // Widget _crearCheckBox2() {
  //   Color getColor(Set<MaterialState> states) {
  //     const Set<MaterialState> interactiveStates = <MaterialState>{
  //       MaterialState.pressed,
  //       MaterialState.hovered,
  //       MaterialState.focused,
  //     };
  //     if (states.any(interactiveStates.contains)) {
  //       return Colors.blue;
  //     }
  //     return Colors.blue;
  //   }

  //   return Checkbox(
  //     checkColor: Colors.white,
  //     fillColor: MaterialStateProperty.resolveWith(getColor),
  //     value: isChecked2,
  //     onChanged: (bool? value) {
  //       setState(() {
  //         isChecked2 = value!;
  //         //sitFamilia.esperaBebe = "No";
  //         _selection4 = 'Felina';
  //       });
  //     },
  //   );
  // }

  Widget _seleccionarEspecie() {
    final dropdownMenuOptions = _especie
        .map((String especie) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(
                value: especie, child: new Text(especie)))
        .toList();
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 10.0)),
        Text(
          'Seleccione especie:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Padding(padding: EdgeInsets.only(top: 10.0)),
        DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 229, 215, 230),
                Color.fromARGB(225, 109, 245, 170),
                Color.fromARGB(255, 210, 235, 250)
                //add more colors
              ]),
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                    blurRadius: 5) //blur radius of shadow
              ]),
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton<String>(
                //hint: Text(animal.tamanio.toString()),
                value: _selection,
                items: dropdownMenuOptions,
                onChanged: (s) {
                  setState(() {
                    _selection = s;
                    //animal.tamanio = s!;
                  });
                }),
          ),
        ),
      ],
    );
  }

  Widget _seleccionarSexo() {
    final dropdownMenuOptions = _sexo
        .map((String sexo) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: sexo, child: new Text(sexo)))
        .toList();
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 10.0)),
        Text(
          'Seleccione genero:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Padding(padding: EdgeInsets.only(top: 10.0)),
        DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 229, 215, 230),
                Color.fromARGB(225, 109, 245, 170),
                Color.fromARGB(255, 210, 235, 250)
                //add more colors
              ]),
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                    blurRadius: 5) //blur radius of shadow
              ]),
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton<String>(
                //hint: Text(animal.tamanio.toString()),
                value: _selection1,
                items: dropdownMenuOptions,
                onChanged: (s) {
                  setState(() {
                    _selection1 = s;
                    //animal.tamanio = s!;
                  });
                }),
          ),
        ),
      ],
    );
  }

  Widget _seleccionarEdad() {
    final dropdownMenuOptions = _edad
        .map((String edad) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: edad, child: new Text(edad)))
        .toList();
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 10.0)),
        Text(
          'Seleccione edad:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Padding(padding: EdgeInsets.only(top: 10.0)),
        DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 229, 215, 230),
                Color.fromARGB(225, 109, 245, 170),
                Color.fromARGB(255, 210, 235, 250)
                //add more colors
              ]),
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                    blurRadius: 5) //blur radius of shadow
              ]),
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton<String>(
                //hint: Text(animal.tamanio.toString()),
                value: _selection2,
                items: dropdownMenuOptions,
                onChanged: (s) {
                  setState(() {
                    _selection2 = s;
                    //animal.tamanio = s!;
                  });
                }),
          ),
        ),
      ],
    );
  }

  Widget _seleccionarTamanio() {
    final dropdownMenuOptions = _tamanio
        .map((String tamanio) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(
                value: tamanio, child: new Text(tamanio)))
        .toList();
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 10.0)),
        Text(
          'Seleccione tamaño:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Padding(padding: EdgeInsets.only(top: 10.0)),
        DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 229, 215, 230),
                Color.fromARGB(225, 109, 245, 170),
                Color.fromARGB(255, 210, 235, 250)
                //add more colors
              ]),
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                    blurRadius: 5) //blur radius of shadow
              ]),
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton<String>(
                //hint: Text(animal.tamanio.toString()),
                value: _selection3,
                items: dropdownMenuOptions,
                onChanged: (s) {
                  setState(() {
                    _selection3 = s;
                    //animal.tamanio = s!;
                  });
                }),
          ),
        ),
      ],
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          return Colors.green;
        }),
      ),
      label: Text('Buscar'),
      icon: Icon(Icons.search),
      autofocus: true,
      //onPressed: (_guardando) ? null : _submit,
      onPressed: () {
        _submit();
      },
    );
  }

  void _submit() async {
    //mostrarSnackbar('Registro guardado');
    //Navigator.pushNamed(context, 'horariosAdd');
    Navigator.pushNamed(context, 'resultadoBusqueda', arguments: {
      'especie': _selection,
      'sexo': _selection1,
      'edad': _selection2,
      'tamanio': _selection3
    });
  }
}
