import 'package:cliente_app_v1/src/widgets/background.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:cliente_app_v1/src/utils/utils.dart' as utils;

class FormDatPersonalesPage extends StatefulWidget {
  //const formDatPersonalesPage({Key? key}) : super(key: key);

  @override
  _FormDatPersonalesPageState createState() => _FormDatPersonalesPageState();
}

class _FormDatPersonalesPageState extends State<FormDatPersonalesPage> {
  final formKey = GlobalKey<FormState>();
  final List<String> _items =
      ['Primaria', 'Secundaria', 'Universidad', 'Posgrado'].toList();
  String? _selection;
  @override
  void initState() {
    // _selection = _items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DATOS PERSONALES',
          // textAlign: TextAlign.center,
        ),
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
                        'Datos personales',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      _crearNombre(),
                      _crearCI(),
                      _crearDireccion(),
                      _crearEdad(),
                      _crearOcupacion(),
                      _crearEmail(),
                      Divider(),
                      Text(
                        'Instrucción',
                        style: TextStyle(
                          fontSize: 33,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.orange[100]!,
                        ),
                      ),
                      Divider(),
                      _crearInstruccion(),
                      Divider(),
                      Text(
                        'Telefonos de contacto',
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
                      _crearTelfCelular(),
                      _crearTelfDomicilio(),
                      _crearTelfTrabajo(),
                      Divider(),
                      Text(
                        'Referencias Personales',
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
                      _crearNombreRef(),
                      _crearParentescoRef(),
                      _crearTelefonoRef()
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Nombre Completo',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearCI() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Cedula',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearEdad() {
    return TextFormField(
      //initialValue: animal.edad.toString(),
      readOnly: true,
      //textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: 'Edad',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
      //onSaved: (value) => animal.edad = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearOcupacion() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Ocupacion',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearEmail() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'E-mail',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearDireccion() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Direccion exacta donde estara la mascota',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearInstruccion() {
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
          'Seleccione nivel de instruccion: ',
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

  Widget _crearTelfDomicilio() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Telefono de domicilio',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearTelfCelular() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Telefono celular',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearTelfTrabajo() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Telefono de trabajo',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearNombreRef() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Nombre',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearParentescoRef() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Parentesco',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _crearTelefonoRef() {
    return TextFormField(
      // initialValue: ,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Telefono',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}
