import 'package:cliente_app_v1/src/models/formulario_domicilio_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormDomicilioPage extends StatefulWidget {
  //const formDatPersonalesPage({Key? key}) : super(key: key);

  @override
  _FormDomicilioPageState createState() => _FormDomicilioPageState();
}

class _FormDomicilioPageState extends State<FormDomicilioPage> {
  final formKey = GlobalKey<FormState>();
  final List<String> _items = ['Casa', 'Departamento', 'Otro'].toList();
  final List<String> _items1 = ['Propio', 'Arrendado'].toList();
  final List<String> _items2 = ['Macho', 'Hembra', 'Ambos'].toList();
  final List<String> _items3 =
      ['Cachorro', 'Joven', 'Adulto', 'Anciano', 'Geriátrico'].toList();
  final List<String> _items4 = ['Pequeño', 'Mediano', 'Grande'].toList();
  final List<String> _items5 = ['Canina', 'Felina'].toList();
  String? _selection;
  String? _selection1;
  String? _selection2;
  String? _selection3;
  String? _selection4;
  String? _selection5;

  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  bool _guardando = false;
  bool isDisable = false;
  var idFormu1;
  var idAnimal;
  String campoVacio = 'Por favor, llena este campo';
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
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    idFormu1 = arg['idFormu'];
    print(idFormu1);
    idAnimal = arg['idAnimal'];
    print(idAnimal);
    return Scaffold(
      backgroundColor: Color.fromARGB(223, 248, 248, 245),
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
                        '¿Qué tipo de inmueble posee?',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.blueGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      //Divider(),
                      Divider(
                        color: Colors.transparent,
                      ),
                      _detalle(),
                      Divider(
                        color: Colors.transparent,
                      ),
                      _crearTipoInmueble(),
                      Row(
                        children: [_crearDimencion(), infoAltura()],
                      ),

                      _crearPropiedad(),
                      Divider(),

                      _buildChild1(),
                      Divider(),
                      Text(
                        '¿Planea mudarse próximamente?',
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
                        'El lugar donde pasará la mascota, ¿Tiene cerramiento?',
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
                      _buildChild2(),
                      // _crearAltura(),
                      // _crearMaterial(),
                      Divider(),
                      Row(
                        children: [Text('No'), _crearCheckBox4()],
                      ),
                      Divider(),
                      Text(
                        '¿Cuál piensa que es la mascota más adecuada para Ud.?',
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
                      _crearEspecie(),
                      _crearSexo(),
                      _crearEdadM(),
                      _crearTamanio(),
                      Divider(),
                      //_crearBotonRevisar(context),
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
    return SizedBox(
      height: 60.0,
      width: 290.0,
      child: TextFormField(
        validator: (value) {
          if (isNumeric(value!)) {
            return null;
          } else {
            return 'Solo números';
          }
        },
        //initialValue: domicilio.m2.toString(),
        readOnly: false,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            labelText: 'Especifique metros (m2)',
            labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
        onChanged: (s) {
          setState(() {
            domicilio.m2 = double.parse(s);
          });
        },
      ),
    );
  }

  Widget _crearTelefono() {
    return TextFormField(
      initialValue: domicilio.telfD,
      readOnly: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)
      ],
      textCapitalization: TextCapitalization.sentences,
      //keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: 'Teléfono',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      validator: (value) {
        if (value!.length < 9 && value.length > 0 || value.length > 10) {
          return 'Ingrese un número de teléfono válido';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      onChanged: (s) {
        setState(() {
          domicilio.telfD = s;
        });
      },
    );
  }

  Widget _crearNombreD() {
    return TextFormField(
      initialValue: domicilio.nombreD,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Nombre',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      validator: (value) {
        if (value!.length < 3 && value.length > 0) {
          return 'Ingrese el nombre';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
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
          'Seleccione tipo de inmueble:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          width: 150.0,
          child: DropdownButtonFormField<String>(
              //hint: Text(animal.tamanio.toString()),
              value: _selection,
              items: dropdownMenuOptions,
              validator: (value) =>
                  value == null ? 'Seleccione una opción' : null,
              onChanged: (s) {
                setState(() {
                  _selection = s;
                  domicilio.tipoInmueble = s!;
                  //animal.tamanio = s!;
                });
              }),
        ),
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
        SizedBox(
          width: 140.0,
          child: DropdownButtonFormField<String>(
              //hint: Text(animal.tamanio.toString()),
              value: _selection1,
              items: dropdownMenuOptions,
              validator: (value) =>
                  value == null ? 'Seleccione una opción' : null,
              onChanged: (s) {
                setState(() {
                  _selection1 = s;
                  domicilio.inmueble = s!;
                  //animal.tamanio = s!;
                });
              }),
        ),
      ],
    );
  }

  Widget _crearAltura() {
    return SizedBox(
      height: 50.0,
      width: 290.0,
      child: TextFormField(
        validator: (value) {
          if (isNumeric(value!)) {
            return null;
          } else {
            return 'Solo números';
          }
        },
        //initialValue: domicilio.alturaC.toString(),
        readOnly: false,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Altura (m)',
        ),
        onChanged: (s) {
          setState(() {
            if (double.parse(s) > 3.0) {
              mostrarAlerta(
                  context, 'La altura ingresada no debe ser mayor a 3m.');
            } else {
              domicilio.alturaC = double.parse(s);
            }
            ;
          });
        },
      ),
    );
  }

  Widget infoAltura() {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            content: Text(
              'Utiliza punto (.) para los decimales\nEjemplo: 2.23',
            ),
            title: Text('Ayuda'),
          ),
        );
      },
      child: Column(
        children: const <Widget>[
          Icon(
            Icons.info_rounded,
            color: Colors.green,
            size: 20.0,
          ),
        ],
      ),
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
        if (isChecked1 == true) {
          return null;
        } else {
          setState(() {
            isChecked = value!;
            domicilio.planMudanza = "Si";
          });
        }
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
        if (isChecked == true) {
          return null;
        } else {
          setState(() {
            isChecked1 = value!;
            domicilio.planMudanza = "No";
          });
        }
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
        if (isChecked3 == true) {
          return null;
        } else {
          setState(() {
            isChecked2 = value!;
            domicilio.cerramiento = "Si";
          });
        }
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
        if (isChecked2 == true) {
          return null;
        } else {
          setState(() {
            isChecked3 = value!;
            domicilio.cerramiento = "No";
          });
        }
      },
    );
  }

  Widget _crearMaterial() {
    return TextFormField(
      validator: (value) {
        if (value!.length < 3 && value.length > 0) {
          return 'Ingrese el material';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      // initialValue: ,
      readOnly: false,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
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

  Widget _crearEspecie() {
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
          'Especie:          ',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          width: 150.0,
          child: DropdownButtonFormField<String>(
              //hint: Text(animal.tamanio.toString()),
              value: _selection5,
              items: dropdownMenuOptions,
              validator: (value) =>
                  value == null ? 'Seleccione una opción' : null,
              onChanged: (s) {
                setState(() {
                  _selection5 = s;
                  domicilio.especieAd = s!;
                  //animal.tamanio = s!;
                });
              }),
        ),
      ],
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
        SizedBox(
          width: 150.0,
          child: DropdownButtonFormField<String>(
              //hint: Text(animal.tamanio.toString()),
              value: _selection2,
              items: dropdownMenuOptions,
              validator: (value) =>
                  value == null ? 'Seleccione una opción' : null,
              onChanged: (s) {
                setState(() {
                  _selection2 = s;
                  domicilio.sexoAd = s!;
                  //animal.tamanio = s!;
                });
              }),
        ),
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
        SizedBox(
          width: 150.0,
          child: DropdownButtonFormField<String>(
              //hint: Text(animal.tamanio.toString()),
              value: _selection3,
              items: dropdownMenuOptions,
              validator: (value) =>
                  value == null ? 'Seleccione una opción' : null,
              onChanged: (s) {
                setState(() {
                  _selection3 = s;
                  domicilio.edadAd = s!;
                  //animal.tamanio = s!;
                });
              }),
        ),
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
        SizedBox(
          width: 150.0,
          child: DropdownButtonFormField<String>(
              //hint: Text(animal.tamanio.toString()),
              value: _selection4,
              items: dropdownMenuOptions,
              validator: (value) =>
                  value == null ? 'Seleccione una opción' : null,
              onChanged: (s) {
                setState(() {
                  _selection4 = s;
                  domicilio.tamanioAd = s!;
                  //animal.tamanio = s!;
                });
              }),
        ),
      ],
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          if (isDisable == true) {
            return Colors.grey;
          } else {
            return Colors.green;
          }
        }),
      ),
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      autofocus: true,
      //onPressed: (_guardando) ? null : _submit,
      onPressed: () {
        if (isDisable == true) {
          return null;
        } else {
          if (formKey.currentState!.validate()) {
            if (isChecked == false && isChecked1 == false) {
              mostrarAlerta(
                  context, 'Debe seleccionar una de las dos opciones.');
            } else if (isChecked2 == false && isChecked3 == false) {
              mostrarAlerta(
                  context, 'Debe seleccionar una de las dos opciones.');
            } else {
              SnackBar(
                content: Text('Información ingresada correctamente.'),
              );
              _submit();
            }
          } else {
            mostrarAlerta(
                context, 'Asegúrate de que todos los campos estén llenos.');
          }
        }
      },
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
    formulariosProvider.crearFormDomicilio(
        domicilio, idFormu1, context, idAnimal);
    // } else {
    //animalProvider.editarAnimal(animal, foto!);
    //print(idFormu);
    // print("Debe llenar la parte 1 para poder continuar");
    //}
  }

  Widget crearBotonRevisar(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            return Colors.green;
          }),
        ),
        label: Text('Revisar'),
        icon: Icon(Icons.reviews),
        autofocus: true,
        onPressed: () {
          _mostrarConfirmacion(context);
        });
  }

  Future _mostrarConfirmacion(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Atención'),
            content: Text(
                'Antes de guardar esta sección, asegúrate de haber llenado todos lo campos con la información solicitada.'),
            actions: [
              TextButton(
                  child: Text('Lo he revisado'),
                  //onPressed: () => Navigator.of(context).pop(),
                  onPressed: () {
                    setState(() {
                      isDisable = false;
                      Navigator.of(context).pop();
                    });
                  }),
              TextButton(
                  child: Text('Revisar'),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          );
        });
  }

  Widget _detalle() {
    return Card(
      child: ListTile(
        title: Text(
          "Formulario: Domicilio",
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'En este formulario debe ingresar características de su domicilio, necesarias para verificar el lugar donde vivirá la mascota adoptada.',
          textAlign: TextAlign.justify,
        ),
      ),
      elevation: 8,
      shadowColor: Colors.green,
      margin: EdgeInsets.all(5),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 1)),
    );
  }

  Widget _buildChild1() {
    if (_selection1 == 'Arrendado') {
      return Column(
        children: [
          Text(
              'Si es arrendado, ponga el nombre y teléfono del dueño de la casa:'),
          Divider(),
          _crearNombreD(),
          _crearTelefono()
        ],
      );
    } //else {
    //   if (_selection == 'Otros') {
    //     return _crearDonacion();
    //   }
    // }
    return Text('');
  }

  Widget _buildChild2() {
    if (isChecked2 == true) {
      return Column(
        children: [
          Row(children: [_crearAltura(), infoAltura()]),
          _crearMaterial()
        ],
      );
    } //else {

    return Text('');
  }
}
