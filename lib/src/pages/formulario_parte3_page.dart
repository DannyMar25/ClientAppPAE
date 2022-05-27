import 'package:cliente_app_v1/src/models/formulario_domicilio_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
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

  bool _guardando = false;
  var idFormu1;
  FormulariosModel formulario = new FormulariosModel();
  //SitFamiliarModel sitFamilia = new SitFamiliarModel();
  //DatosPersonalesModel datoPersona = new DatosPersonalesModel();
  DomicilioModel domicilio = new DomicilioModel();
  FormulariosProvider formulariosProvider = new FormulariosProvider();

  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formData = ModalRoute.of(context)!.settings.arguments;
    if (formData != null) {
      //   formulario = formData as FormulariosModel;
      idFormu1 = formData;
      //   print(formulario.id);
    }
    return Scaffold(
      //backgroundColor: Color.fromARGB(223, 221, 248, 153),
      backgroundColor: Color.fromARGB(223, 211, 212, 207),
      appBar: AppBar(
        title: Text('DOMICILIO'),
        backgroundColor: Colors.green,
      ),
      drawer: MenuWidget(),
      body: Stack(
        children: [
          //Background(),
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
                            ..color = Colors.blueGrey,
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
                            ..color = Colors.blueGrey,
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
                            ..color = Colors.blueGrey,
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
                            ..color = Colors.blueGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      _crearSexo(),
                      _crearEdadM(),
                      _crearTamanio(),
                      Divider(),
                      _crearBoton(),
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
      initialValue: domicilio.m2.toString(),
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Especifique metros (m2)',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          domicilio.m2 = double.parse(s);
        });
      },
    );
  }

  Widget _crearTelefono() {
    return TextFormField(
      initialValue: domicilio.telfD,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      //keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: 'Telefono',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          domicilio.telfD = s;
        });
      },
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
      initialValue: domicilio.nombreD,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Nombre',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          domicilio.nombreD = s;
        });
      },
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
                domicilio.tipoInmueble = s!;
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
                domicilio.inmueble = s!;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearAltura() {
    return TextFormField(
      initialValue: domicilio.alturaC.toString(),
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Altura (m2)',
      ),
      onChanged: (s) {
        setState(() {
          domicilio.alturaC = double.parse(s);
        });
      },
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
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          domicilio.planMudanza = "Si";
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
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked1,
      onChanged: (bool? value) {
        setState(() {
          isChecked1 = value!;
          domicilio.planMudanza = "No";
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
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked2,
      onChanged: (bool? value) {
        setState(() {
          isChecked2 = value!;
          domicilio.cerramiento = "Si";
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
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked3,
      onChanged: (bool? value) {
        setState(() {
          isChecked3 = value!;
          domicilio.cerramiento = "No";
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
      onChanged: (s) {
        setState(() {
          domicilio.materialC = s;
        });
      },
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
                domicilio.sexoAd = s!;
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
                domicilio.edadAd = s!;
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
                domicilio.tamanioAd = s!;
                //animal.tamanio = s!;
              });
            }),
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
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      autofocus: true,
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    setState(() {
      _guardando = true;
    });
//Sentencia If agregada recientemente
    //if (idFormu != null) {
    print(idFormu1);
    formulariosProvider.crearFormDomicilio(domicilio, idFormu1, context);
    // } else {
    //animalProvider.editarAnimal(animal, foto!);
    //print(idFormu);
    // print("Debe llenar la parte 1 para poder continuar");
    //}
  }
}
