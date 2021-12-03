import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class FormRelacionMascotas1Page extends StatefulWidget {
  //const formDatPersonalesPage({Key? key}) : super(key: key);

  @override
  _FormRelacionMascotas1PageState createState() =>
      _FormRelacionMascotas1PageState();
}

class _FormRelacionMascotas1PageState extends State<FormRelacionMascotas1Page> {
  final formKey = GlobalKey<FormState>();
  final List<String> _items = ['Canino', 'Felino', 'Otro'].toList();
  final List<String> _items1 = [
    'Viaja con Ud.',
    'Se queda con un familiar',
    'Hospedaje',
    'Otro'
  ].toList();
  final List<String> _items2 =
      ['Balanceado', 'Comida Casera', 'Restos', 'Otro'].toList();
  final List<String> _items3 = [
    'Lo lleva al veterinario',
    'Lo medica usted mismo',
    'Lo lleva al centro de salud',
    'Espera que se sane solo'
  ].toList();
  final List<String> _items4 = ['5 a 20', '21 a 50', '51 en adelante'].toList();
  final List<String> _items5 = [
    'Totalmente de acuerdo',
    'Lo aceptan por Ud.',
    'Desacuerdo',
    'Indiferente'
  ].toList();
  final List<String> _items6 = ['M', 'H'].toList();
  final List<String> _items7 = ['Si', 'No'].toList();
  String? _selection;
  String? _selection1;
  String? _selection2;
  String? _selection3;
  String? _selection4;
  String? _selection5;
  String? _selection6;
  String? _selection7;
  String? _selection8;
  String? _selection9;

  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;
  bool isChecked8 = false;
  bool isChecked9 = false;

  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RELACION CON LOS ANIMALES'),
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
                        'Liste sus dos ultimas mascotas',
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
                      DataTable(
                        sortColumnIndex: 2,
                        sortAscending: false,
                        columns: [
                          DataColumn(label: Text("Tipo")),
                          DataColumn(label: Text("Nombre")),
                          DataColumn(label: Text("Sexo")),
                          DataColumn(label: Text("Este")),
                        ],
                        rows: [
                          DataRow(selected: true, cells: [
                            DataCell(_crearTipoMascota()),
                            DataCell(_crearNombreM()),
                            DataCell(_crearSexo()),
                            DataCell(_crearSiNo())
                          ]),
                          DataRow(cells: [
                            DataCell(_crearTipoMascota1()),
                            DataCell(_crearNombreM()),
                            DataCell(_crearSexo1()),
                            DataCell(_crearSiNo1())
                          ]),
                        ],
                      ),
                      Divider(),
                      _crearLugarM(),
                      Divider(),
                      _crearPregunta1(),
                      _crearPregunta2(),
                      _crearPregunta3(),
                      Divider(),
                      Text(
                        'Si Ud. debe salir de viaje más de un día, la mascota:',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      _crearViaje(),
                      Divider(),
                      _crearPregunta4(),
                      _crearPregunta5(),
                      _crearPregunta6(),
                      _crearPregunt7(),
                      Divider(),
                      Text(
                        '¿Qué comerá habitualmente la mascota?:           ',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      _crearComida(),
                      Divider(),
                      _crearPregunta8(),
                      Divider(),
                      Text(
                        'Si su mascota se enferma usted: ',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                      _crearEnfermedad(),
                      Divider(),
                      _crearPregunta9(),
                      Divider(),
                      Text(
                        'Estime cuánto dinero podía gastar en su mascota mensualmente:   ',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      _crearGastos(),
                      Divider(),
                      _crearPregunta10(),
                      Divider(),
                      Text(
                        '¿Esta de acuerdo en que se haga una visita periódica a su domicilio para ver como se encuentra el adoptado?',
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
                      _crearPorque(),
                      Divider(),
                      Text(
                        '¿Está de acuerdo en que la  mascota sea esterilizada?',
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
                      Divider(),
                      Row(
                        children: [Text('No'), _crearCheckBox4()],
                      ),
                      _crearPorque(),
                      Divider(),
                      _crearPregunta11(),
                      _crearPregunta12(),
                      _crearPregunta13(),
                      Divider(),
                      Text(
                        'La adopción fue compartida con su familia?',
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
                      _crearSiNo(),
                      Divider(),
                      _crearFamilia()
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearLugarM() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText:
              'Donde esta ahora? Si fallecio, perdio o esta en otro lugar, indique la causa.',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearNombreM() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      // decoration: InputDecoration(
      //     labelText: 'Nombre Mascota',
      //     labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearTipoMascota() {
    final dropdownMenuOptions = _items
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   'Seleccione el tipo de mascota:    ',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
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

  Widget _crearTipoMascota1() {
    final dropdownMenuOptions = _items
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   'Seleccione el tipo de mascota:    ',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection9,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection9 = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearPorque() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Por qué?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta1() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Por qué desea adoptar una mascota?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta2() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText:
              'Si por algún motivo tuviera que cambiar de domicilio, ¿Qué pasaría con su mascota?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta3() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText:
              'Con relación a la anterior pregunta ¿Qué pasaria si los dueños de la nueva casa no aceptan mascotas?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta4() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Cuánto tiempo en el dia pasará sola la mascota?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta5() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Dónde pasará durante el día y la noche?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta6() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Dónde dormirá la mascota?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunt7() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Dónde hará sus necesidades?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta8() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Cuántos años cree que vive un perro en promedio?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta9() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText:
              '¿Quién será el responsable y se hará cargo de cubrir los gastos de la mascota?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta10() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText:
              '¿Cuenta con los recursos para cubrir los gastos veterinarios del animal de compañía?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta11() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Conoce usted los beneficios de la esterilización?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta12() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Según usted que es tenencia responsable?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearPregunta13() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText:
              '¿Está Ud. informado y conciente sobre la ordenanza municipal sobre la tenencia responsable de mascotas?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
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

  Widget _crearViaje() {
    final dropdownMenuOptions = _items2
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   'Si Ud. debe salir de viaje más de un día, la mascota:      ',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
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

  Widget _crearComida() {
    final dropdownMenuOptions = _items2
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   '¿Qué comerá habitualmente la mascota?:           ',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
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

  Widget _crearEnfermedad() {
    final dropdownMenuOptions = _items3
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   'Si su mascota se enferma usted: ',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
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

  Widget _crearGastos() {
    final dropdownMenuOptions = _items4
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   'Estime cuánto dinero podía gastar en su mascota mensualmente:   ',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
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

  Widget _crearFamilia() {
    final dropdownMenuOptions = _items5
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Su familia está:        ',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection5,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection5 = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearSexo() {
    final dropdownMenuOptions = _items6
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   '',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection6,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection6 = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearSexo1() {
    final dropdownMenuOptions = _items6
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   '',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection8,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection8 = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearSiNo() {
    final dropdownMenuOptions = _items7
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   '',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection7,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection7 = s;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearSiNo1() {
    final dropdownMenuOptions = _items7
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Text(
        //   '',
        //   style: TextStyle(fontSize: 16, color: Colors.black),
        // ),
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
}