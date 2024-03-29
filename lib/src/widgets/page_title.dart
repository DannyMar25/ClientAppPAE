import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Solicitud de adocpion',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Modulos a llenar para la solicitud de adopcion de una mascota',
              style: TextStyle(fontSize: 14, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
