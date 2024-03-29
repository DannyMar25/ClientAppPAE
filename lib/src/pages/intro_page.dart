import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:badges/badges.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late FirebaseMessaging messaging;
  late int total = 0;
  final userProvider = new UsuarioProvider();
  final prefs = new PreferenciasUsuario();
  final _headerStyle = const TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyle = const TextStyle(
      color: Color.fromARGB(255, 17, 17, 17),
      fontSize: 14,
      fontWeight: FontWeight.normal);
  final _loremIpsum =
      '''PoliPet es una app dedicada a difundir la adopción de mascotas, nuestro principal objetivo es mejorar la calidad de vida de animalitos que no tienen un hogar.''';
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    //backgroundColor: Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

  @override
  void initState() {
    super.initState();
    final email = prefs.email;
    final uid = prefs.uid;
    if (email != '') {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        print("tokeen+++======");
        print(value);
        userProvider.saveFcmToken(uid, value!);
      });
      messaging.onTokenRefresh.listen((fcmToken) {
        print("refreshToken");
        print(fcmToken);
        userProvider.saveFcmToken(uid, fcmToken);
      }).onError((err) {
        print(err);
      });
    }
    userProvider.mostrarTotalNotificacion(prefs.uid).then((value) => {
          setState(() {
            print(total);
            total = value;
            print(total);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final email = prefs.email;
    String nombre = prefs.nombre.toString();
    String nombreS = nombre.split(' ')[0];
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        //centerTitle: true,
        title: Text(
          'Inicio',
          textAlign: TextAlign.left,
        ),
        backgroundColor: Colors.green,
        actions: [
          email != ''
              ? Badge(
                  badgeContent: Text(total.toString(),
                      style: TextStyle(color: Colors.white)),
                  position: BadgePosition.topEnd(top: 3, end: 0),
                  child: IconButton(
                    //onSelected: (item) => onSelected(context, item),
                    icon: Icon(
                      Icons.notifications,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'notificaciones');
                    },
                  ),
                )
              : SizedBox(),
          PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              icon: Icon(Icons.account_circle),
              itemBuilder: (context) => [
                    email == ''
                        ? PopupMenuItem<int>(
                            child: Text("Iniciar sesión"),
                            value: 0,
                          )
                        : PopupMenuItem<int>(
                            child: Text("Cerrar Sesión"),
                            value: 2,
                          ),
                    email == ''
                        ? PopupMenuItem<int>(
                            child: Text("Registrarse"),
                            value: 1,
                          )
                        : PopupMenuItem(child: Text('')),
                  ]),
        ],
      ),
      drawer: MenuWidget(),
      body: ListView(
        shrinkWrap: true,
        children: [
          //Padding(padding: EdgeInsets.only(bottom: 5.0)),
          SizedBox(
            child: Image(image: AssetImage('assets/dog_an5.gif')),
            height: 160,
          ),
          email != ''
              ? Text(
                  '¡Hola!, ' + nombreS,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )
              : SizedBox(),
          SizedBox(
            height: 700,
            child: Accordion(
              maxOpenSections: 1,
              headerBackgroundColorOpened: Colors.black54,
              //scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  isOpen: true,
                  leftIcon: const Icon(Icons.pets, color: Colors.white),
                  headerBackgroundColor: Colors.green,
                  headerBackgroundColorOpened: Colors.green,
                  header: Text('¿Qué es PoliPet?', style: _headerStyle),
                  content: Text(
                    _loremIpsum,
                    style: _contentStyle,
                    textAlign: TextAlign.justify,
                  ),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 1,
                  // onOpenSection: () => print('onOpenSection ...'),
                  // onCloseSection: () => print('onCloseSection ...'),
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon:
                      const Icon(Icons.photo_library, color: Colors.white),
                  header:
                      Text('Encuentra tu mascota ideal', style: _headerStyle),
                  contentBorderColor: const Color(0xffffffff),
                  headerBackgroundColor: Color.fromARGB(251, 236, 122, 193),
                  headerBackgroundColorOpened: Colors.purple,
                  content: Column(
                    children: [
                      Accordion(
                        maxOpenSections: 1,
                        headerBackgroundColorOpened: Colors.black54,
                        headerPadding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 15),
                        children: [
                          AccordionSection(
                            isOpen: false,
                            leftIcon: const Icon(Icons.photo_album,
                                color: Colors.white),
                            headerBackgroundColor:
                                Color.fromARGB(95, 128, 21, 122),
                            headerBackgroundColorOpened:
                                Color.fromARGB(137, 118, 28, 153),
                            header: Text(
                              'Galería',
                              style: _headerStyle,
                              textAlign: TextAlign.justify,
                            ),
                            content: Column(
                              children: [
                                Text('Encuentra tu mascota.',
                                    style: _contentStyle),
                                SizedBox(
                                  child: Image(
                                    image: AssetImage("assets/dog_an5.gif"),
                                  ),
                                  height: 100.0,
                                ),
                                TextButton(
                                  style: flatButtonStyle,
                                  onPressed: () {
                                    //cardB.currentState?.collapse();
                                    Navigator.pushNamed(context, 'home');
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.photo_library_outlined,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                      ),
                                      Text(
                                        'Galería',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            contentHorizontalPadding: 20,
                            contentBorderColor: Colors.black54,
                          ),
                          AccordionSection(
                            isOpen: false,
                            leftIcon:
                                const Icon(Icons.search, color: Colors.white),
                            header: Text('Búsqueda', style: _headerStyle),
                            headerBackgroundColor:
                                Color.fromARGB(95, 235, 30, 149),
                            headerBackgroundColorOpened:
                                Color.fromARGB(137, 211, 49, 162),
                            contentBorderColor: Colors.black54,
                            content: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Image(
                                        image: AssetImage("assets/pet.jpg"),
                                      ),
                                      height: 100.0,
                                    ),
                                    Flexible(
                                        flex: 1,
                                        child: Text(
                                            'Puedes usar el buscador si deseas encontrar una mascota que se adapte a tu estilo de vida.',
                                            textAlign: TextAlign.justify,
                                            style: _contentStyle)),
                                  ],
                                ),
                                TextButton(
                                  style: flatButtonStyle,
                                  onPressed: () {
                                    //cardB.currentState?.collapse();
                                    Navigator.pushNamed(context, 'busqueda');
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.search,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                      ),
                                      Text(
                                        'Buscador',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(child: Image(image: AssetImage("assets/bienvenida.png"),)),
                    ],
                  ),
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon:
                      const Icon(Icons.edit_calendar, color: Colors.white),
                  header: Text('Agenda una cita', style: _headerStyle),
                  headerBackgroundColor: Colors.blue,
                  headerBackgroundColorOpened:
                      Color.fromARGB(255, 32, 108, 170),
                  content: Column(
                    children: [
                      Text(
                          "Si deseas conocer más animalitos puedes agendar una cita y visitarnos."),
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {
                          //cardB.currentState?.collapse();
                          Navigator.pushNamed(context, 'registroCita');
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'Agendar cita',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon: const Icon(Icons.list_alt, color: Colors.white),
                  header: Text('¡Adopta!', style: _headerStyle),
                  headerBackgroundColor: Color.fromARGB(255, 170, 124, 248),
                  content: Column(
                    children: [
                      Text.rich(
                        TextSpan(
                            style: TextStyle(),
                            text:
                                'Para poder llevar a cabo este proceso debes haber seleccionado a tu futura mascota de nuestra galería y dentro de su perfil dar clic en la opción ',
                            children: [
                              TextSpan(
                                  text: '¡Quiero Adoptarlo!.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ]),
                        textAlign: TextAlign.justify,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      Text(
                        'Ten en cuenta que para poder realizar este proceso debes iniciar sesión o registrarte en la aplicación.',
                        textAlign: TextAlign.justify,
                      ),
                      //"Para poder llevar a cabo este proceso debes haber seleccionado a tu futura mascota de nuestra galeria y dentro de su perfil dar clic en la opcion '¡Quiero Adoptarlo!'", textAlign: TextAlign.justify,),

                      //Text(
                      // "Ten en cuenta que para poder relalizar este proceso debes iniciar sesion o registrate en la aplicacion."),
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, 'home');
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.photo_album,
                              color: Colors.green,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'Ver mascotas',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      // Wrap(
                      //   children: List.generate(
                      //       30,
                      //       (index) => const Icon(Icons.contact_page,
                      //           size: 30, color: Color(0xff999999))),
                      // ),
                    ],
                  ),
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon: const Icon(Icons.pets, color: Colors.white),
                  header: Text('Ingresa la información de tu mascota adoptada',
                      style: _headerStyle),
                  content: Column(
                    children: [
                      Text(
                        "Si ya enviaste el formulario de adopción y has recibido una respuesta positiva, puedes llevar un control de tu mascota en la sección de Seguimiento.",
                        textAlign: TextAlign.justify,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      Text(
                        "Ten en cuenta que para ingresar a esta sección debemos comprobar si tus datos son correctos.",
                        textAlign: TextAlign.justify,
                      ),
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, 'evidencia');
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.verified,
                              color: Colors.green,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'Verificar estado de adopción',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  headerBackgroundColor: Color.fromARGB(255, 240, 160, 39),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, 'login');
        break;
      case 1:
        Navigator.pushNamed(context, 'registro');
        break;
      case 2:
        userProvider.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => IntroPage()),
            (Route<dynamic> route) => false);
      //Navigator.pushNamed(context, 'intro');
    }
  }
}
