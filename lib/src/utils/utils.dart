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

void mostrarAlertaAuth(BuildContext context, String mensaje, String ruta) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Correo invalido'),
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

void mostrarOkFormulario(
    BuildContext context, String mensaje, String ruta, String idFormu) {
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
                onPressed: () =>
                    Navigator.pushNamed(context, ruta, arguments: idFormu)),
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

validarCedula(String cedula, BuildContext context) {
  //Preguntamos si la cedula consta de 10 digitos
  if (cedula.length == 10) {
    //Obtenemos el digito de la region que sonlos dos primeros digitos
    var digito_region = int.parse(cedula.substring(0, 2));

    //Pregunto si la region existe ecuador se divide en 24 regiones
    if (digito_region >= 1 && digito_region <= 24) {
      // Extraigo el ultimo digito
      var ultimo_digito = int.parse(cedula.substring(9, 10));

      //Agrupo todos los pares y los sumo
      var pares = int.parse(cedula.substring(1, 2)) +
          int.parse(cedula.substring(3, 4)) +
          int.parse(cedula.substring(5, 6)) +
          int.parse(cedula.substring(7, 8));

      //Agrupo los impares, los multiplico por un factor de 2, si la resultante es > que 9 le restamos el 9 a la resultante
      var numero1 = int.parse(cedula.substring(0, 1));
      numero1 = (numero1 * 2);
      if (numero1 > 9) {
        numero1 = (numero1 - 9);
      }

      var numero3 = int.parse(cedula.substring(2, 3));
      numero3 = (numero3 * 2);
      if (numero3 > 9) {
        numero3 = (numero3 - 9);
      }

      var numero5 = int.parse(cedula.substring(4, 5));
      numero5 = (numero5 * 2);
      if (numero5 > 9) {
        numero5 = (numero5 - 9);
      }

      var numero7 = int.parse(cedula.substring(6, 7));
      numero7 = (numero7 * 2);
      if (numero7 > 9) {
        numero7 = (numero7 - 9);
      }

      var numero9 = int.parse(cedula.substring(8, 9));
      numero9 = (numero9 * 2);
      if (numero9 > 9) {
        numero9 = (numero9 - 9);
      }

      var impares = numero1 + numero3 + numero5 + numero7 + numero9;

      //Suma total
      var suma_total = (pares + impares);

      //extraemos el primero digito
      var primer_digito_suma = (suma_total).toString().substring(0, 1);

      //Obtenemos la decena inmediata
      var decena = (int.parse(primer_digito_suma) + 1) * 10;

      //Obtenemos la resta de la decena inmediata - la suma_total esto nos da el digito validador
      var digito_validador = decena - suma_total;

      //Si el digito validador es = a 10 toma el valor de 0
      if (digito_validador == 10) var digito_validador = 0;

      //Validamos que el digito validador sea igual al de la cedula
      if (digito_validador == ultimo_digito) {
        print('la cedula:' + cedula + ' es correcta');
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Informacion incorrecta'),
                content: Text('Numero de cedula incorrecto'),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            });
        print('la cedula:' + cedula + ' es incorrecta');
      }
    } else {
      // imprimimos en consola si la region no pertenece
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Informacion incorrecta'),
              content: Text('Cedula no pertenece a ninguna region'),
              actions: [
                TextButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
      print('Esta cedula no pertenece a ninguna region');
    }
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Informacion incorrecta'),
            content: Text('Debe tener al meno 10 digitos'),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
    //imprimimos en consola si la cedula tiene mas o menos de 10 digitos
    print('Esta cedula tiene mas o menos de 10 Digitos');
  }
}

String? validarEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value))
    return 'Ingrese una dirección de correo valida.';
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
