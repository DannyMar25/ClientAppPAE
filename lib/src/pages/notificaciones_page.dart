import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({Key? key}) : super(key: key);

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Text('NotificacionesScreen'),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.notification_important))
          ],
        ),
      ),
    );
  }
}
