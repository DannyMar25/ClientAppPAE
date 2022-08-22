import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/models/formulario_relacionAnimal_model.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
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
      ['Croquetas', 'Comida Casera', 'Restos', 'Otro'].toList();
  final List<String> _items3 = [
    'Lo lleva al veterinario',
    'Lo medica usted mismo',
    'Lo lleva al centro de salud',
    'Espera que se sane solo'
  ].toList();
  final List<String> _items4 =
      ['\$5 a \$20', '\$21 a \$50', '\$51 en adelante'].toList();
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
  String? _selection10;
  String? _selection11;

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

  //bool _guardando = false;
  bool isDisable = true;
  var idFormu2;
  var idAnimal;
  String campoVacio = 'Por favor, llena este campo';
  FormulariosModel formulario = new FormulariosModel();
  //DatosPersonalesModel datoPersona = new DatosPersonalesModel();
  RelacionAnimalesModel relacionAnim = new RelacionAnimalesModel();
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  AnimalesProvider animalesProvider = new AnimalesProvider();
  AnimalModel animales = new AnimalModel();

  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    idFormu2 = arg['idFormu'];
    print(idFormu2);
    idAnimal = arg['idAnimal'];
    print(idAnimal);
    // var formData = ModalRoute.of(context)!.settings.arguments;
    // if (formData != null) {
    //   idFormu2 = formData;
    // }
    return Scaffold(
      //backgroundColor: Color.fromARGB(223, 211, 212, 207),
      backgroundColor: Color.fromARGB(223, 248, 248, 245),
      appBar: AppBar(
        title: Text('RELACIÓN CON LOS ANIMALES'),
        backgroundColor: Colors.green,
      ),
      drawer: MenuWidget(),
      body: Stack(
        children: [
          //Background(),
          SingleChildScrollView(
            child: Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.transparent,
                        ),
                        _detalle(),
                        Divider(
                          color: Colors.transparent,
                        ),
                        Text(
                          'Liste sus dos últimas mascotas',
                          style: TextStyle(
                            fontSize: 33,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Divider(),
                        DataTable(
                          columnSpacing: 25,
                          sortColumnIndex: 2,
                          sortAscending: false,
                          columns: [
                            DataColumn(label: Text("Tipo")),
                            DataColumn(label: Text("Nombre")),
                            DataColumn(label: Text("Sexo")),
                            DataColumn(label: Text("Esterilizado")),
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
                              DataCell(_crearNombreM1()),
                              DataCell(_crearSexo1()),
                              DataCell(_crearSiNo1())
                            ]),
                          ],
                        ),
                        Divider(),
                        Text(
                          '¿Dónde está ahora? Si falleció, perdió o está en otro lugar, indique la causa.',
                          style: TextStyle(fontSize: 16),
                        ),
                        _crearLugarM(),
                        Divider(),
                        _crearPregunta1(),
                        Divider(
                          color: Colors.transparent,
                        ),
                        Text(
                          'Si por algún motivo tuviera que cambiar de domicilio, ¿Qué pasaría con su mascota?',
                          style: TextStyle(fontSize: 16),
                        ),
                        _crearPregunta2(),
                        Text(
                          'Con relación a la anterior pregunta ¿Qué pasaría si los dueños de la nueva casa no aceptan mascotas?',
                          style: TextStyle(fontSize: 16),
                        ),
                        Divider(
                          color: Colors.transparent,
                        ),
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
                        Text(
                          '¿Cuántos años cree que vive un perro en promedio?',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        _crearPregunta8(),
                        Divider(),
                        Text(
                          'Si su mascota se enferma usted: ',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.justify,
                        ),
                        _crearEnfermedad(),
                        Divider(),
                        Text(
                          '¿Quién será el responsable y se hará cargo de cubrir los gastos de la mascota?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        _crearPregunta9(),
                        Divider(),
                        Text(
                          'Estime cuánto dinero podía gastar en su mascota mensualmente:   ',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        _crearGastos(),
                        Divider(),
                        Text(
                          '¿Cuenta con los recursos para cubrir los gastos veterinarios del animal de compañía?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        _crearPregunta10(),
                        Divider(),
                        Text(
                          '¿Está de acuerdo en que se haga una visita periódica a su domicilio para ver como se encuentra el adoptado?',
                          style: TextStyle(
                            fontSize: 26,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
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
                        _crearPorque1(),
                        Divider(),
                        Text(
                          '¿Está de acuerdo en que la  mascota sea esterilizada?',
                          style: TextStyle(
                            fontSize: 26,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.blueGrey,
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
                        _crearPorque2(),
                        Divider(),
                        _crearPregunta11(),
                        _crearPregunta12(),
                        Divider(
                          color: Colors.transparent,
                        ),
                        Text(
                          '¿Está Ud. informado y conciente sobre la ordenanza municipal sobre la tenencia responsable de mascotas?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        _crearPregunta13(),
                        Divider(),
                        Text(
                          'La adopción fue compartida con su familia?',
                          style: TextStyle(
                            fontSize: 26,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Divider(),
                        _crearSiNo2(),
                        Divider(),
                        _crearFamilia(),
                        Divider(),
                        _crearBotonRevisar(context),
                        _crearBoton(),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearLugarM() {
    return TextFormField(
      validator: (value) {
        if (value!.length < 3 && value.length > 0) {
          return 'El texto ingresado es muy corto';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      textAlign: TextAlign.justify,
      initialValue: relacionAnim.ubicMascota,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          //contentPadding: const EdgeInsets.all(0.0),
          // labelText:
          //     'Donde esta ahora? Si fallecio, perdio o esta en otro lugar, indique la causa.',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.ubicMascota = s;
        });
      },
    );
  }

  Widget _crearNombreM() {
    return TextFormField(
      validator: (value) {
        if (value!.length < 1 && value.length > 0) {
          return 'Ingrese el nombre';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      initialValue: relacionAnim.nombreMs1,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          relacionAnim.nombreMs1 = s;
        });
      },
      // decoration: InputDecoration(
      //     labelText: 'Nombre Mascota',
      //     labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearNombreM1() {
    return TextFormField(
      validator: (value) {
        if (value!.length < 1 && value.length > 0) {
          return 'Ingrese el nombre';
        } else if (value.isEmpty) {
          return campoVacio;
        } else {
          return null;
        }
      },
      initialValue: relacionAnim.nombreMs1,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (s) {
        setState(() {
          relacionAnim.nombreMs2 = s;
        });
      },
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
                relacionAnim.tipoMs1 = s!;
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
                relacionAnim.tipoMs2 = s!;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearPorque1() {
    return TextFormField(
      // initialValue: ,
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Por qué?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.justificacion1 = s;
        });
      },
    );
  }

  Widget _crearPorque2() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Por qué?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.justificacion2 = s;
        });
      },
    );
  }

  Widget _crearPregunta1() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.deseoAdop,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Por qué desea adoptar una mascota?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.deseoAdop = s;
        });
      },
    );
  }

  Widget _crearPregunta2() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.cambioDomi,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          // labelText:
          //     'Si por algún motivo tuviera que cambiar de domicilio, ¿Qué pasaría con su mascota?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.cambioDomi = s;
        });
      },
    );
  }

  Widget _crearPregunta3() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.relNuevaCasa,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          //labelText:
          //   'Con relación a la anterior pregunta ¿Qué pasaria si los dueños de la nueva casa no aceptan mascotas?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.relNuevaCasa = s;
        });
      },
    );
  }

  Widget _crearPregunta4() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.tiempoSolaMas,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Cuánto tiempo en el día pasará sola la mascota? (Horas)',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.tiempoSolaMas = s;
        });
      },
    );
  }

  Widget _crearPregunta5() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.diaNocheMas,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Dónde pasará durante el día y la noche?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.diaNocheMas = s;
        });
      },
    );
  }

  Widget _crearPregunta6() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.duermeMas,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Dónde dormirá la mascota?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.duermeMas = s;
        });
      },
    );
  }

  Widget _crearPregunt7() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.necesidadMas,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Dónde hará sus necesidades?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.necesidadMas = s;
        });
      },
    );
  }

  Widget _crearPregunta8() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.promedVida,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          //labelText: '¿Cuántos años cree que vive un perro en promedio?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.promedVida = s;
        });
      },
    );
  }

  Widget _crearPregunta9() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.responGastos,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          // labelText:
          //    '¿Quién será el responsable y se hará cargo de cubrir los gastos de la mascota?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.responGastos = s;
        });
      },
    );
  }

  Widget _crearPregunta10() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.recursoVet,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          //labelText:
          //    '¿Cuenta con los recursos para cubrir los gastos veterinarios del animal de compañía?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.recursoVet = s;
        });
      },
    );
  }

  Widget _crearPregunta11() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.benefEst,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Conoce usted los beneficios de la esterilización?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.benefEst = s;
        });
      },
    );
  }

  Widget _crearPregunta12() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.tenenciaResp,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: '¿Según usted que es tenencia responsable?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.tenenciaResp = s;
        });
      },
    );
  }

  Widget _crearPregunta13() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return campoVacio;
        }
        return null;
      },
      initialValue: relacionAnim.ordenMuni,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          //labelText:
          //   '¿Está Ud. informado y conciente sobre la ordenanza municipal sobre la tenencia responsable de mascotas?',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          relacionAnim.ordenMuni = s;
        });
      },
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
            relacionAnim.visitaPer = "Si";
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
            relacionAnim.visitaPer = "No";
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
            relacionAnim.acuerdoEst = "Si";
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
            relacionAnim.acuerdoEst = "No";
          });
        }
      },
    );
  }

  Widget _crearViaje() {
    final dropdownMenuOptions = _items1
        .map((String item) =>
            //new DropdownMenuItem<String>(value: item, child: new Text(item)))
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        DropdownButton<String>(
            //hint: Text(animal.tamanio.toString()),
            value: _selection1,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection1 = s;
                relacionAnim.viajeMascota = s!;
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
                relacionAnim.comidaMas = s!;
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
                relacionAnim.enfermedadMas = s!;
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
                relacionAnim.dineroMas = s!;
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
                relacionAnim.famAcuerdo = s!;
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
                relacionAnim.sexoMs1 = s!;
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
                relacionAnim.sexoMs2 = s!;
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
                relacionAnim.estMs1 = s!;
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
            value: _selection10,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection10 = s;
                relacionAnim.estMs2 = s!;
                //animal.tamanio = s!;
              });
            }),
      ],
    );
  }

  Widget _crearSiNo2() {
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
            value: _selection11,
            items: dropdownMenuOptions,
            onChanged: (s) {
              setState(() {
                _selection11 = s;
                relacionAnim.estMs2 = s!;
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
                  context, 'Debe seleccionar una de las dos opciones');
            } else {
              SnackBar(
                content: Text('Información ingresada correctamente'),
              );
              _submit();
            }
          } else {
            mostrarAlerta(
                context, 'Asegurate de que todos los campos estén llenos.');
          }
        }
      },
    );
  }

  void _submit() async {
    // if (!formKey.currentState!.validate()) return;
    // formKey.currentState!.save();
    // setState(() {
    //   _guardando = true;
    // });
//Sentencia If agregada recientemente
    //if (idFormu != null) {
    print(idFormu2);
    animales = await animalesProvider.cargarAnimalId(idAnimal);

    animalesProvider.editarEstado(animales, 'Pendiente');
    formulariosProvider.crearFormRelacionAnim(
      relacionAnim,
      idFormu2,
      context,
    );
    // } else {
    //animalProvider.editarAnimal(animal, foto!);
    //print(idFormu);
    // print("Debe llenar la parte 1 para poder continuar");
    //}
  }

  Widget _crearBotonRevisar(BuildContext context) {
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
                'Antes de guardar esta sección, asegurate de haber llenado todos lo campos con la información solicitada.'),
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
          "Formulario: Relación con los animales",
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'En este formulario debe responder algunas preguntas acerca de su relación con los animales...',
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
}
