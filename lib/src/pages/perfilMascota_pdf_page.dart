import 'package:cliente_app_v1/src/models/animales_model.dart';
import 'package:cliente_app_v1/src/models/formulario_principal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class CrearPerfilMascotaPdfPage extends StatefulWidget {
  const CrearPerfilMascotaPdfPage({Key? key}) : super(key: key);

  @override
  State<CrearPerfilMascotaPdfPage> createState() => _CrearPerfilPdfPageState();
}

class _CrearPerfilPdfPageState extends State<CrearPerfilMascotaPdfPage> {
  AnimalModel animal = new AnimalModel();
  File? foto;
  FormulariosModel formularios = new FormulariosModel();

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    //if (dat == arg['datosper']) {
    formularios = arg['formulario'] as FormulariosModel;
    animal = arg['animal'] as AnimalModel;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: Center(
            child: TextButton(
                onPressed: _createPDF,
                child: Text(
                  'Ver perfil de ${animal.nombre} en formato pdf.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ))));
  }

  Future<void> _createPDF() async {
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
    row11.cells[0].value = 'Características:';
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
}
