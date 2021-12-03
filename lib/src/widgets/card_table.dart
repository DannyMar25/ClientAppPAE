import 'dart:ui';

import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          InkWell(
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'formularioP1'),
            child: _SingleCard(
              color: Colors.blue,
              icon: Icons.border_all,
              text: 'Datos personales',
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'formularioP2'),
            child: _SingleCard(
              color: Colors.pinkAccent,
              icon: Icons.car_rental,
              text: 'Situacion Familiar',
            ),
          ),
        ]),
        TableRow(children: [
          InkWell(
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'formularioP3'),
            child: _SingleCard(
              color: Colors.purple,
              icon: Icons.shop,
              text: 'Domicilio',
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'formularioP4'),
            child: _SingleCard(
              color: Colors.blue,
              icon: Icons.cloud,
              text: 'Relacion con los animales 1',
            ),
          ),
        ]),
        TableRow(children: [
          InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
            child: _SingleCard(
              color: Colors.orange,
              icon: Icons.movie,
              text: 'Relacion con los animales 2',
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
            child: _SingleCard(
              color: Colors.pinkAccent,
              icon: Icons.food_bank,
              text: 'Grocery',
            ),
          ),
        ]),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard(
      {Key? key, required this.icon, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: this.color,
          child: Icon(
            this.icon,
            size: 35,
            color: Colors.white,
          ),
          radius: 30,
        ),
        SizedBox(
          height: 10,
        ),
        Text(this.text,
            style: TextStyle(color: this.color, fontSize: 18),
            textAlign: TextAlign.center),
      ],
    );
    return _CardBackground(
      child: column,
    );
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;
  const _CardBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            //margin: EdgeInsets.all(15),
            height: 180,
            decoration: BoxDecoration(
                color: Color.fromRGBO(62, 66, 107, 0.7),
                borderRadius: BorderRadius.circular(20)),
            child: this.child,
          ),
        ),
      ),
    );
  }
}
