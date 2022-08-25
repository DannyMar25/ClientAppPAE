import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información incorrecta'),
          content: Text(mensaje),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
}

void mostrarAlertaAuth(BuildContext context, String mensaje, String ruta) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Correo inválido'),
          content: Text(mensaje),
          actions: [
            TextButton(
                child: Text('Ok'),
                //onPressed: () => Navigator.of(context).pop(),
                onPressed: () => Navigator.pushNamed(context, ruta)),
          ],
        );
      });
}

void mostrarAlertaOk(
    BuildContext context, String mensaje, String ruta, String titulo) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              Text(titulo),
            ],
          ),
          content: Text(mensaje),
          actions: [
            TextButton(
                child: Text('Ok'),
                //onPressed: () => Navigator.of(context).pop(),
                onPressed: () => Navigator.pushNamed(context, ruta)),
          ],
        );
      });
}

void mostrarOkRegistros(
    BuildContext context,
    String mensaje,
    String titulo,
    String ruta,
    DatosPersonalesModel datosA,
    FormulariosModel formularios,
    AnimalModel animal) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              Text(titulo),
            ],
          ),
          content: Text(mensaje),
          actions: [
            TextButton(
                child: Text('Ok'),
                onPressed: () => Navigator.pushNamed(context, ruta, arguments: {
                      'datosper': datosA,
                      'formulario': formularios,
                      'animal': animal
                    }))
            //onPressed: () => Navigator.of(context).pop()),
            //onPressed: () => Navigator.pushNamed(context, ruta)),
          ],
        );
      });
}

void mostrarOkFormulario(BuildContext context, String mensaje, String ruta,
    String idFormu, AnimalModel animal) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              Text('Información correcta'),
            ],
          ),
          content: Text(mensaje),
          actions: [
            TextButton(
                child: Text('Ok'),
                //onPressed: () => Navigator.of(context).pop(),
                onPressed: () => Navigator.pushNamed(context, ruta,
                    arguments: {'idFormu': idFormu, 'animal': animal})),
          ],
        );
      });
}

void mostrarAlertaOkCancel(
    BuildContext context, String mensaje, String ruta, AnimalModel animal) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Aviso'),
          content: Text(mensaje),
          actions: [
            TextButton(
                child: Text('Ok'),
                //onPressed: () => Navigator.of(context).pop(),
                onPressed: () =>
                    Navigator.pushNamed(context, ruta, arguments: animal)),
            TextButton(
                child: Text('Cancelar'),
                //onPressed: () => Navigator.of(context).pop(),
                onPressed: () => Navigator.of(context).pop()),
          ],
        );
      });
}

String? validarEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value))
    return 'Ingrese una dirección de correo válida.';
  else
    return null;
}

validadorDeCedula(String cedula) {
  bool cedulaCorrecta = false;

  if (cedula.length == 10) // ConstantesApp.LongitudCedula
  {
    int tercerDigito = int.parse(cedula.substring(2, 3));
    if (tercerDigito < 6) {
      List<int> coefValCedula = [2, 1, 2, 1, 2, 1, 2, 1, 2];
      int verificador = int.parse(cedula.substring(9, 10));
      int suma = 0;
      int digito = 0;
      for (int i = 0; i < (cedula.length - 1); i++) {
        digito = int.parse(cedula.substring(i, i + 1)) * coefValCedula[i];
        suma += ((digito % 10) + (digito / 10)).toInt();
      }
      if ((suma % 10 == 0) && (suma % 10 == verificador)) {
        cedulaCorrecta = true;
        print('La cedula es correcta');
      } else if ((10 - (suma % 10)) == verificador) {
        cedulaCorrecta = true;
        print('La cedula es correcta');
      } else {
        cedulaCorrecta = false;
        print('La cedula es incorrecta');
      }
    } else {
      cedulaCorrecta = false;
      print('La cedula es incorrecta');
    }
  } else {
    cedulaCorrecta = false;
    print('La cedula es incorrecta');
  }
  if (!cedulaCorrecta) {
    print("La Cédula ingresada es Incorrecta");
  }
  return cedulaCorrecta;
}
