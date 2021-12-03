import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class FormDomicilioPage extends StatefulWidget {
  //const formDatPersonalesPage({Key? key}) : super(key: key);

  @override
  _FormDomicilioPageState createState() => _FormDomicilioPageState();
}

class _FormDomicilioPageState extends State<FormDomicilioPage> {
  final formKey = GlobalKey<FormState>();
  final List<String> _items = ['Casa', 'Departamento', 'Otro'].toList();
  final List<String> _items1 = ['Propio', 'Arrendado'].toList();
  final List<String> _items2 = ['Macho', 'Hembra'].toList();
  final List<String> _items3 = ['Adulto', 'Cachorro'].toList();
  final List<String> _items4 = ['Pequeño', 'Mediano', 'Grande'].toList();
  String? _selection;
  String? _selection1;
  String? _selection2;
  String? _selection3;
  String? _selection4;

  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DOMICILIO'),
      ),
      drawer: MenuWidget(),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Que tipo de inmueble posee?',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      _crearTipoInmueble(),
                      _crearDimencion(),
                      _crearPropiedad(),
                      Divider(),
                      Text(
                          'Si es arrendado, ponga el nombre y telefono del dueño de la casa:'),
                      Divider(),
                      _crearNombreD(),
                      _crearTelefono(),
                      Divider(),
                      Text(
                        'Planea mudarse proximamente?',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      Row(
                        children: [Text('Si'), _crearCheckBox1()],
                      ),
                      Row(
                        children: [Text('No'), _crearCheckBox2()],
                      ),
                      Divider(),
                      Text(
                        'El lugar donde pasara la mascota, tiene cerramiento?',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      Row(
                        children: [Text('Si'), _crearCheckBox3()],
                      ),
                      _crearAltura(),
                      _crearMaterial(),
                      Divider(),
                      Row(
                        children: [Text('No'), _crearCheckBox4()],
                      ),
                      Divider(),
                      Text(
                        'Cual piensa que es la mascota mas adecuada para Ud.?',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      _crearSexo(),
                      _crearEdadM(),
                      _crearTamanio(),
                      Divider(),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearDimencion() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Especifique metros (m2)',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearTelefono() {
    return TextFormField(
      //initialValue: animal.edad.toString(),
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      //keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: 'Telefono',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      // //onSaved: (value) => animal.edad = int.parse(value!),
      // validator: (value) {
      //   if (utils.isNumeric(value!)) {
      //     return null;
      //   } else {
      //     return 'Solo numeros';
      //   }
      // },
    );
  }

  Widget _crearNombreD() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Nombre',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearTipoInmueble() {
    final dropdownMenuOptions = _items
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Seleccione tipo de inmueble:    ',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearPropiedad() {
    final dropdownMenuOptions = _items1
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'El inmueble es:    ',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection1,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection1 = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearAltura() {
    return TextFormField(
      //initialValue: animal.peso.toString(),
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Altura (m2)',
      ),
      //onSaved: (value) => animal.peso = double.parse(value!),
      // validator: (value) {
      //   if (utils.isNumeric(value!)) {
      //     return null;
      //   } else {
      //     return 'Solo numeros';
      //   }
      // },
    );
  }

  Widget _crearCheckBox1() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }

  Widget _crearCheckBox2() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked1,
      onChanged: (bool? value) {
        setState(() {
          isChecked1 = value!;
        });
      },
    );
  }

  Widget _crearCheckBox3() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked2,
      onChanged: (bool? value) {
        setState(() {
          isChecked2 = value!;
        });
      },
    );
  }

  Widget _crearCheckBox4() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked3,
      onChanged: (bool? value) {
        setState(() {
          isChecked3 = value!;
        });
      },
    );
  }

  Widget _crearMaterial() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Material',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearSexo() {
    final dropdownMenuOptions = _items2
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Sexo:            ',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection2,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection2 = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearEdadM() {
    final dropdownMenuOptions = _items3
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Edad:           ',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection3,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection3 = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearTamanio() {
    final dropdownMenuOptions = _items4
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Tamaño:     ',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection4,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection4 = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }
}
