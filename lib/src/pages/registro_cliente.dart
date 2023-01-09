//import 'dart:async';

import 'dart:async';

import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RegistroClientePage extends StatefulWidget {
  // const RegistroClientePage({Key? key}) : super(key: key);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-0.29952092852665996, -78.48033408388217),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  _RegistroClientePageState createState() => _RegistroClientePageState();
}

class _RegistroClientePageState extends State<RegistroClientePage> {
  Completer<GoogleMapController> _controller = Completer();

  late double latitude, longitude;
  //final animalProvider = new AnimalesProvider();
  late DocumentSnapshot datosUbic;

  List<Marker> myMarker = [];
  //Completer<GoogleMapController> _controller = Completer();
  final firestoreInstance = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final userProvider = new UsuarioProvider();

  TextEditingController nombre = new TextEditingController();
  TextEditingController telefono = new TextEditingController();

  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MenuWidget(),
      appBar: AppBar(
        title: Text('Registro Cliente'),
        actions: [
          Builder(builder: (BuildContext context) {
            return TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                userProvider.signOut();
                Navigator.pushNamed(context, 'login');
              },
              child: Text('Sign Out'),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearTelefono(),
                Divider(),
                _verMapa(),
                //_crearBotonUbicacion(),
                // _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      //initialValue: animal.nombre,
      controller: nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
      ),
      onSaved: (value) => nombre = value as TextEditingController,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese su nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearTelefono() {
    return TextFormField(
      //initialValue: animal.nombre,
      controller: telefono,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Telefono',
      ),
      onSaved: (value) => telefono = value as TextEditingController,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese su numero de telefono';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          return Colors.deepPurple;
        }),
      ),
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      autofocus: true,
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    LocationData currentLocation;
    var location = new Location();
    currentLocation = await location.getLocation();
    Map<String, dynamic> posicionRegistrada = {
      "lat": currentLocation.latitude,
      "long": currentLocation.longitude
    };

    //Guardar datos en base
    Map<String, dynamic> clientes = {
      "nombre": nombre.text,
      "telefono": telefono.text,
      "posicionRegistrada": posicionRegistrada
    };
    firestoreInstance.collection("clients").add(clientes);

    Navigator.pushNamed(context, 'bienvenida');
  }

  Widget _verMapa() {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            myLocationButtonEnabled: true,
            padding: EdgeInsets.only(
              top: 40.0,
            ),
            mapType: MapType.normal,
            initialCameraPosition: RegistroClientePage._kGooglePlex,
            markers: Set.from(myMarker),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: _handleTap,
          ),
        ),
        FloatingActionButton.extended(
          onPressed: _currentLocation,
          label: Text('Mi Ubicacion'),
          icon: Icon(Icons.location_on),
        ),
      ],
    );
  }

  void _currentLocation() async {
    //final GoogleMapController controller = await _controller.future;
    //LocationData currentLocation;
    //var location = new Location();
    // try {
    //   currentLocation = await location.getLocation();
    // } on Exception {
    //   currentLocation = null!;
    // }

    // controller.animateCamera(CameraUpdate.newCameraPosition(
    //   CameraPosition(
    //     bearing: 0,
    //     target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
    //     zoom: 17.0,
    //   ),
    // ));
  }

  _handleTap(LatLng tappedPoint) {
    //if (tappedPoint != null) {
    print(tappedPoint);
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
      latitude = tappedPoint.latitude;

      longitude = tappedPoint.longitude;
    });
    //}
  }
}
