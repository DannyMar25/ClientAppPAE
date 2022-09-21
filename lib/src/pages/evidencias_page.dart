import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_datosPersonales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:cliente_app_v1/src/providers/usuario_provider.dart';
import 'package:cliente_app_v1/src/utils/utils.dart';
import 'package:cliente_app_v1/src/widgets/menu_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class EvidenciasPage extends StatefulWidget {
  const EvidenciasPage({Key? key}) : super(key: key);

  @override
  State<EvidenciasPage> createState() => _EvidenciasPageState();
}

class _EvidenciasPageState extends State<EvidenciasPage> {
  final formKey = GlobalKey<FormState>();
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  AnimalesProvider animalesProvider = new AnimalesProvider();

  //List<Future<FormulariosModel>> formulario = [];
  List<FormulariosModel> formularios = [];
  List<Future<FormulariosModel>> listaF = [];
  FirebaseStorage storage = FirebaseStorage.instance;
  AnimalModel animal = new AnimalModel();
  DatosPersonalesModel datosC = new DatosPersonalesModel();
  String identificacion = '';
  bool _guardando = false;
  final prefs = new PreferenciasUsuario();
  final userProvider = new UsuarioProvider();
  @override
  void initState() {
    super.initState();
    //showCitas();
  }

  @override
  Widget build(BuildContext context) {
    final email = prefs.email;
    return Scaffold(
        appBar: AppBar(
          title: Text('Revisión de solicitud'),
          backgroundColor: Colors.green,
          actions: [
            email != ''
                ? PopupMenuButton<int>(
                    onSelected: (item) => onSelected(context, item),
                    icon: Icon(Icons.notifications),
                    itemBuilder: (context) => [])
                : SizedBox(),
            PopupMenuButton<int>(
                onSelected: (item) => onSelected(context, item),
                icon: Icon(Icons.manage_accounts),
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
            // Builder(builder: (BuildContext context) {
            //   return Row(
            //     children: [
            //       email == ''
            //           ? TextButton(
            //               style: ButtonStyle(
            //                 foregroundColor:
            //                     MaterialStateProperty.all<Color>(Colors.white),
            //               ),
            //               onPressed: () async {
            //                 Navigator.pushNamed(context, 'login');
            //               },
            //               child: Text('Iniciar sesión'),
            //             )
            //           : TextButton(
            //               style: ButtonStyle(
            //                 foregroundColor:
            //                     MaterialStateProperty.all<Color>(Colors.white),
            //               ),
            //               onPressed: () async {
            //                 userProvider.signOut();
            //                 Navigator.pushNamed(context, 'home');
            //               },
            //               child: Text('Cerrar sesión'),
            //             ),
            //       email == ''
            //           ? TextButton(
            //               style: ButtonStyle(
            //                 foregroundColor:
            //                     MaterialStateProperty.all<Color>(Colors.white),
            //               ),
            //               onPressed: () async {
            //                 Navigator.pushNamed(context, 'registro');
            //               },
            //               child: Text('Registrarse'),
            //             )
            //           : SizedBox(),
            //     ],
            //   );
            // }),
          ],
        ),
        drawer: MenuWidget(),
        body: SingleChildScrollView(
            child: Container(
                //color: Colors.lightGreenAccent,
                padding: new EdgeInsets.only(top: 10.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        mostrarImagen1(),
                        _crearCI(),
                        Divider(
                          color: Colors.white,
                        ),
                        _crearBoton(),
                        Divider(
                          color: Colors.white,
                        ),
                        _verListado()
                      ],
                    )))));
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
        Navigator.pushNamed(context, 'intro');
    }
  }

  Widget mostrarImagen1() {
    return SizedBox(
      height: 200.0,
      child: Image(
        image: AssetImage('assets/cat_1.gif'),
      ),
    );
  }

  Widget _crearCI() {
    return TextFormField(
      //initialValue: ,
      readOnly: false,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Ingrese su número de cédula:',
          labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
      onChanged: (s) {
        setState(() {
          identificacion = s;
        });
      },
      validator: (value) {
        if (value!.length < 10 || value.length > 10 && value.length > 0) {
          return 'Ingrese número de cédula válido';
        } else if (value.isEmpty) {
          return 'Por favor, llena este campo';
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
            return Colors.green;
          }),
        ),
        label: Text(
          'Verificar',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.verified,
          color: Colors.white,
        ),
        autofocus: true,
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            SnackBar(
              content: Text('Información ingresada correctamente'),
            );
            final estadoCedula =
                await formulariosProvider.verificar(identificacion);
            if (estadoCedula.isEmpty) {
              mostrarAlertaOk(context, 'No se ha encontrado ningun registo.',
                  'evidencia', 'Atención!');
            } else {
              _submit();
            }
          } else {
            mostrarAlerta(context,
                'Asegúrate de haber ingresado correctamente el número de cédula');
          }
        });
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    setState(() {
      _guardando = true;
    });
    showCitas(identificacion);
  }

  showCitas(String identificacion) async {
    formularios.clear();
    listaF = await formulariosProvider.cargarInfo(identificacion);
    for (var yy in listaF) {
      FormulariosModel form = await yy;
      setState(() {
        formularios.add(form);
      });
    }
  }

  Widget _verListado() {
    //return verificarCedula();
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: formularios.length,
            itemBuilder: (context, i) => _crearItem(context, formularios[i]),
          ),
        ),
      ],
    );
  }

  Widget _crearItem(BuildContext context, FormulariosModel formulario) {
    if (formulario.estado == 'Aprobado') {
      return Card(
          color: Colors.lightGreen[200],
          shadowColor: Colors.green,
          child: InkWell(
            onTap: () async {
              datosC = await formulariosProvider.cargarDPId(
                  formulario.id, formulario.idDatosPersonales);
              animal =
                  await animalesProvider.cargarAnimalId(formulario.idAnimal);

              Navigator.pushNamed(context, 'seguimientoMain', arguments: {
                'datosper': datosC,
                'formulario': formulario,
                'animal': animal
              });
            },
            child: Column(
              children: [
                ListTile(
                  title: Column(
                    children: [
                      //Divider(color: Colors.purple),
                      Text("Nombre del cliente: " +
                          '${formulario.nombreClient}'),
                      Text("Número de cédula: " '${formulario.identificacion}'),
                      Text("Estado de solicitud:"
                          '${formulario.estado}'),
                      Text("Fecha de aprobación de solicitud: "
                          '${formulario.fechaRespuesta}'),
                      Text("Nombre mascota adoptada:"
                          '${formulario.animal!.nombre}'),
                      //Divider(color: Colors.purple)
                    ],
                  ),
                  //subtitle: Text('${horario}'),
                ),
                SizedBox(
                  height: 150.0,
                  child: Image(
                    image: AssetImage('assets/dog_an8.gif'),
                  ),
                ),
                Text(
                  '¡Haz click aquí!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ));
    } else if (formulario.estado == 'Pendiente') {
      return Card(
          color: Colors.lightGreen[200],
          shadowColor: Colors.green,
          child: InkWell(
            onTap: () async {},
            child: Column(
              children: [
                ListTile(
                  title: Column(
                    children: [
                      //Divider(color: Colors.purple),
                      Text("Nombre del cliente: " +
                          '${formulario.nombreClient}'),
                      Text("Número de cédula: " '${formulario.identificacion}'),
                      Text("Estado de solicitud: "
                          '${formulario.estado}'),
                      Text("Nombre mascota adoptada: "
                          '${formulario.animal!.nombre}'),
                      //Divider(color: Colors.purple)
                      Divider(
                        color: Colors.transparent,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          //backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ),
                        onPressed: () async {
                          animal = await animalesProvider
                              .cargarAnimalId(formulario.idAnimal);
                          _createPDF(animal);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.photo_library_outlined,
                              color: Colors.green,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'Ver Perfil de Mascota en PDF',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //subtitle: Text('${horario}'),
                ),
                SizedBox(
                  height: 200.0,
                  child: Image(
                    image: AssetImage('assets/cat_4.gif'),
                  ),
                )
              ],
            ),
          ));
    } else {
      return Card(
          color: Colors.lightGreen[200],
          shadowColor: Colors.green,
          child: InkWell(
            onTap: () async {},
            child: Column(
              children: [
                ListTile(
                  title: Column(
                    children: [
                      //Divider(color: Colors.purple),
                      Text("Nombre del cliente: " +
                          '${formulario.nombreClient}'),
                      Text("Número de cédula: " '${formulario.identificacion}'),
                      Text("Estado de solicitud: "
                          '${formulario.estado}'),
                      Text("Nombre mascota adoptada: "
                          '${formulario.animal!.nombre}'),
                      //Divider(color: Colors.purple)
                    ],
                  ),
                  //subtitle: Text('${horario}'),
                ),
                SizedBox(
                  height: 200.0,
                  child: Image(
                    image: AssetImage('assets/dog_an10.gif'),
                  ),
                )
              ],
            ),
          ));
    }
  }

  Future<void> _createPDF(AnimalModel animal) async {
//Create a new PDF document
    PdfDocument document = PdfDocument();

//Add a page to the document
    PdfPage page = document.pages.add();

//Draw image on the page in the specified location and with required size
    page.graphics.drawImage(PdfBitmap(await _readImageData('pet-care.png')),
        Rect.fromLTWH(180, 5, 100, 100));

//Imagen en pdf
    var url = animal.fotoUrl;
    var response = await get(Uri.parse(url));
    var data = response.bodyBytes;
    //Create a bitmap object.
    PdfBitmap image = PdfBitmap(data);

    //Draw an image to the document.
    page.graphics.drawImage(image, Rect.fromLTWH(180, 160, 150, 150));

//Load the paragraph text into PdfTextElement with standard font
    PdfTextElement textElement = PdfTextElement(
        text:
            'Varios estudios han demostrado que tener una mascota no solo alargará tu vida, sino que también aumentarán tu felicidad y mejorarán tu salud en general. Además, las mascotas ayudan a las personas con depresión, estrés y ansiedad.',
        font: PdfStandardFont(PdfFontFamily.helvetica, 12));

    PdfLayoutResult layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 110, page.getClientSize().width, page.getClientSize().height))!;

    textElement.text = 'DATOS DE LA MASCOTA';

    textElement.font =
        PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold);

    layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 160, 0, 0))!;

    //Create a PdfGrid
    PdfGrid grid = PdfGrid();

//Add the columns to the grid
    grid.columns.add(count: 2);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = '  ';
    header.cells[1].value = 'DATOS MASCOTA';
    header.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    header.cells[1].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 90, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );

//Add rows to grid
    PdfGridRow row1 = grid.rows.add();
    row1.cells[0].value = 'Nombre:';
    row1.cells[1].value = animal.nombre;
    PdfGridRow row2 = grid.rows.add();
    row2.cells[0].value = 'Especie:';
    row2.cells[1].value = animal.especie;
    PdfGridRow row3 = grid.rows.add();
    row3.cells[0].value = 'Sexo:';
    row3.cells[1].value = animal.sexo;
    PdfGridRow row4 = grid.rows.add();
    row4.cells[0].value = 'Etapa de vida:';
    row4.cells[1].value = animal.etapaVida;
    PdfGridRow row5 = grid.rows.add();
    row5.cells[0].value = 'Peso:';
    row5.cells[1].value = animal.peso.toString() + 'Kg.';
    PdfGridRow row6 = grid.rows.add();
    row6.cells[0].value = 'Color:';
    row6.cells[1].value = animal.color;
    PdfGridRow row7 = grid.rows.add();
    row7.cells[0].value = 'Tamaño:';
    row7.cells[1].value = animal.tamanio;
    PdfGridRow row8 = grid.rows.add();
    row8.cells[0].value = 'Temperamento';
    row8.cells[1].value = animal.temperamento;
    PdfGridRow row9 = grid.rows.add();
    row9.cells[0].value = 'Raza:';
    row9.cells[1].value = animal.raza;
    PdfGridRow row10 = grid.rows.add();
    row10.cells[0].value = 'Esterilizado:';
    row10.cells[1].value = animal.esterilizado;
    PdfGridRow row11 = grid.rows.add();
    row11.cells[0].value = 'Caracteristicas:';
    row11.cells[1].value = animal.caracteristicas;
    //Estilo de celdas titulo
    row1.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row2.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row3.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row4.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row5.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row6.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row7.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row8.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row9.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row10.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row11.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 2, right: 0, top: 2, bottom: 0),
      font: PdfStandardFont(PdfFontFamily.helvetica, 9),
      //textBrush: PdfBrushes.white,
      textPen: PdfPens.black,
    );
    row1.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row2.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row3.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row4.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row5.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row6.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row7.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row8.cells[1].style = PdfGridCellStyle(
      //backgroundBrush: PdfBrushes.lightSteelBlue,
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row9.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row10.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
    row11.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 3, right: 0, top: 2, bottom: 0),
    );
//Draw grid on the page of PDF document and store the grid position in PdfLayoutResult
    grid.draw(
        //page: document.pages.add(),
        page: page,
        bounds: Rect.fromLTWH(
            0, layoutResult.bounds.bottom + 5, 500, 600)); //500 500

    final List<int> bytes = document.saveSync();
    //Dispose the document
    document.dispose();

    //Get external storage directory
    Directory directory = (await getApplicationDocumentsDirectory());
    //Get directory path
    String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/${'Perfil' + '-' + animal.nombre}.pdf');
    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFile.open('$path/${'Perfil' + '-' + animal.nombre}.pdf');
  }

  Future<List<int>> _readImageData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
