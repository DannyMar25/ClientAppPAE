import 'package:cliente_app_v1/src/models/animales_model.dart';
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
          title: Text('Informacion incorrecta'),
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

void mostrarAlertaOk(BuildContext context, String mensaje, String ruta) {
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
              Text('Informacion correcta'),
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
                child: Text('Cancel'),
                //onPressed: () => Navigator.of(context).pop(),
                onPressed: () => Navigator.of(context).pop()),
          ],
        );
      });
}
