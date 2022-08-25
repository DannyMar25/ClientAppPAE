import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:cliente_app_v1/src/providers/animales_provider.dart';
import 'package:cliente_app_v1/src/providers/formularios_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PerfilMainPage extends StatefulWidget {
  const PerfilMainPage({Key? key}) : super(key: key);

  @override
  State<PerfilMainPage> createState() => _PerfilMainPageState();
}

class _PerfilMainPageState extends State<PerfilMainPage> {
  FormulariosProvider formulariosProvider = new FormulariosProvider();
  AnimalesProvider animalesProvider = new AnimalesProvider();

  //List<Future<FormulariosModel>> formulario = [];
  List<FormulariosModel> formularios = [];
  List<Future<FormulariosModel>> listaF = [];
  //FormulariosModel formulario = new FormulariosModel();
  var idFormu2;
  final formKey = GlobalKey<FormState>();

  AnimalModel animal = new AnimalModel();
  @override
  void initState() {
    super.initState();
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    idFormu2 = arg['idFormu'];
    print(idFormu2);
    animal = arg['animal'] as AnimalModel;
    print(animal.id);

    showCitas(idFormu2);
  }

  @override
  Widget build(BuildContext context) {
    // var formData = ModalRoute.of(context)!.settings.arguments;
    // if (formData != null) {
    //   //   formulario = formData as FormulariosModel;
    //   idFormu2 = formData;
    //   //   print(formulario.id);
    //   print(idFormu2);
    // }
    // final arg = ModalRoute.of(context)!.settings.arguments as Map;
    // idFormu2 = arg['idFormu'];
    // print(idFormu2);
    // animal = arg['animal'] as AnimalModel;
    // print(animal.id);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            },
          ),
          title: Text('Información enviada en solicitud'),
        ),
        body: Stack(alignment: Alignment.center, children: [
          //Background(),
          //_verGaleria(context),
          //Text('Hola'),
          SingleChildScrollView(
              child: Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                      //color: Colors.lightGreenAccent,
                      //padding: new EdgeInsets.only(top: 230.0),
                      child: Form(
                          key: formKey,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //_mostrarImagen(),
                              Padding(padding: EdgeInsets.only(top: 110.0)),
                              _verListado(),
                              //Padding(padding: EdgeInsets.only(bottom: 10.0)),
                              _botonGaleria(),
                            ],
                          )))))
        ]));
  }

  Widget _mostrarImagen() {
    return Card(
        color: Colors.lightGreen[200],
        shadowColor: Colors.green,
        child: InkWell(
          onTap: () async {
            _submit();
          },
          child: Column(
            children: [
              SizedBox(
                height: 150.0,
                child: Image(
                  image: AssetImage('assets/dog_an9.gif'),
                ),
              ),
              Text(
                '¡Haz clic aquí!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }

  void _submit() async {
    showCitas(idFormu2);
  }

  showCitas(String idFormu2) async {
    formularios.clear(); //limpiar lista
    listaF = await formulariosProvider.cargarInfoAnimal(idFormu2);
    //listaF = await formulariosProvider.cargarInfoAnimal('zVIHuMEUoqupCznzHNhG');
    for (var yy in listaF) {
      FormulariosModel form = await yy;
      setState(() {
        formularios.add(form);
      });
    }
  }

  Widget _verListado() {
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
    //if (formulario.estado == 'Pendiente') {
    var fecha = DateTime.parse(formulario.fechaIngreso);
    var fechaIngreso = fecha.year.toString() +
        '-' +
        fecha.month.toString() +
        '-' +
        fecha.day.toString();

    return Card(
        color: Colors.lightGreen[200],
        shadowColor: Colors.green,
        child: InkWell(
          onTap: () async {
            animal = await animalesProvider.cargarAnimalId(formulario.idAnimal);
            _createPDF(animal);

            // Navigator.pushNamed(context, 'perfilMascotaPdf',
            //     arguments: {'formulario': formulario, 'animal': animal});
          },
          child: Column(
            children: [
              ListTile(
                title: Column(
                  children: [
                    //Divider(color: Colors.purple),
                    Text("Nombre del cliente: " + '${formulario.nombreClient}'),
                    Text("Número de cédula: " '${formulario.identificacion}'),
                    Text("Estado de solicitud:"
                        '${formulario.estado}'),
                    // Text("Fecha de envio de solicitud: "
                    //     '${formulario.fechaIngreso}'),
                    Text("Fecha de envio de solicitud: "
                        '$fechaIngreso'),
                    Text("Nombre mascota a adoptar:"
                        '${animal.nombre}'),
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
                '¡Ver perfil de mascota en PDF!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
    // } else {
    //   return SizedBox();
    // }
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
    row5.cells[1].value = animal.peso.toString();
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
        bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 5, 500, 600));

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

  Widget _botonGaleria() {
    return OutlinedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, 'home');
        },
        icon: Icon(
          Icons.photo_album,
          size: 30,
          color: Colors.green,
        ),
        label: Text(
          "Volver a la galería",
          style: TextStyle(color: Colors.green, fontSize: 14),
        ));
  }
}
