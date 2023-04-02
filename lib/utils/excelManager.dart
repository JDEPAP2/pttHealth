import 'dart:io';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:open_file/open_file.dart';
import 'package:ptt_health/class/record.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ExcelManager{

  ExcelManager({
    required this.fileName,
    required this.data
  });

  final Workbook workbook =  Workbook();
  final String fileName;
  final List<Record> data;
  String path = '';
  
  saveExcel(List<int> bytes, String path) async{
    try{
        Directory directory = await path_provider.getApplicationSupportDirectory();
        String newPath = path == ''?'${directory.path}/$fileName':'$path/$fileName';
        File file = File(newPath);
        await file.writeAsBytes(bytes, flush: true);
        final result = await OpenFile.open(newPath);
    }catch(err){
      print(err);
    }
  }

  generateExcel({path=''}) async{
    //Accessing via index
    Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = false;

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();

    //Set data in the worksheet.
    sheet.getRangeByName('A1').columnWidth = 4.82;
    sheet.getRangeByName('B1:C1').columnWidth = 13.82;
    sheet.getRangeByName('D1').columnWidth = 9;
    sheet.getRangeByName('E1').columnWidth = 9;
    sheet.getRangeByName('F1').columnWidth = 9.73;
    sheet.getRangeByName('G1').columnWidth = 10;
    sheet.getRangeByName('H1').columnWidth = 4.46;

    sheet.getRangeByName('A1:H1').cellStyle.backColor = '#333F4F';
    sheet.getRangeByName('A1:H1').merge();
    sheet.getRangeByName('B4:F6').merge();

    sheet.getRangeByName('B4').setText('Registros de Glucosa');
    sheet.getRangeByName('B4').cellStyle.fontSize = 32;

    sheet.getRangeByName('B8').setText('Paciente:');
    sheet.getRangeByName('B8').cellStyle.fontSize = 9;
    sheet.getRangeByName('B8').cellStyle.bold = true;

    sheet.getRangeByName('B9').setText('Samir Jose Escobar');
    sheet.getRangeByName('B9').cellStyle.fontSize = 12;

    sheet
        .getRangeByName('B10')
        .setText('Colombia, Valle del Cauca, Cali');
    sheet.getRangeByName('B10').cellStyle.fontSize = 9;

    sheet.getRangeByName('B11').setText('Calle 48 #94-80');
    sheet.getRangeByName('B11').cellStyle.fontSize = 9;

    sheet.getRangeByName('B12').setNumber(79579976);
    sheet.getRangeByName('B12').cellStyle.fontSize = 9;
    sheet.getRangeByName('B12').cellStyle.hAlign = HAlignType.left;

    final Range range1 = sheet.getRangeByName('F8:G8');
    final Range range2 = sheet.getRangeByName('F9:G9');
    final Range range3 = sheet.getRangeByName('F10:G10');
    final Range range4 = sheet.getRangeByName('F11:G11');
    final Range range5 = sheet.getRangeByName('F12:G12');

    range1.merge();
    range2.merge();
    range3.merge();
    range4.merge();
    range5.merge();

    // sheet.getRangeByName('F8').setText('Motivo:');
    // range1.cellStyle.fontSize = 8;
    // range1.cellStyle.bold = true;
    // range1.cellStyle.hAlign = HAlignType.right;

    // sheet.getRangeByName('F9').setNumber(2058557939);
    // range2.cellStyle.fontSize = 9;
    // range2.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F10').setText('Fecha');
    range3.cellStyle.fontSize = 8;
    range3.cellStyle.bold = true;
    range3.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F11').dateTime = DateTime.now();
    sheet.getRangeByName('F11').numberFormat =
        r'[$-x-sysdate]dddd, mmmm dd, yyyy';
    range4.cellStyle.fontSize = 9;
    range4.cellStyle.hAlign = HAlignType.right;

    range5.cellStyle.fontSize = 8;
    range5.cellStyle.bold = true;
    range5.cellStyle.hAlign = HAlignType.right;

    final Range range6 = sheet.getRangeByName('B15:G15');
    range6.cellStyle.fontSize = 10;
    range6.cellStyle.bold = true;

    sheet.getRangeByIndex(15, 2).setText('Fecha');
    sheet.getRangeByIndex(15, 3).setText('Hora');
    sheet.getRangeByIndex(15, 5).setText('Jornada');
    sheet.getRangeByIndex(15, 6).setText('Valor');
    sheet.getRangeByIndex(15, 7).setText('Nivel');

    for(int i = 0; i < data.length;i++){
      sheet.getRangeByIndex(16+i, 2).setText(data[i].date.toString());
      sheet.getRangeByIndex(16+i, 3).setText(data[i].hour.toString());
      sheet.getRangeByIndex(16+i, 5).setText(data[i].type?'Ayunas':'Nocturna');
      sheet.getRangeByIndex(16+i, 6).setText(data[i].numb.toString());

      String nivel = '';
      String color = '';

      if(data[i].numb < 100 ){
        nivel = data[i].numb < 70? 'Bajo': 'Normal';
        color = data[i].numb < 70? '#81DAF5' : '#9FF781';
      }else{
        nivel = data[i].numb < 126? 'Prediabetes': 'Diabetes';
        color = data[i].numb < 126? '#F4FA58' : '#F78181';
      }
      sheet.getRangeByIndex(16+i, 7).setText(nivel);
      sheet.getRangeByIndex(16+i, 7).cellStyle.backColor = color;
    }


    // sheet.getRangeByIndex(16, 7).setFormula('=E16*F16+(E16*F16)');
    // sheet.getRangeByIndex(17, 7).setFormula('=E17*F17+(E17*F17)');
    // sheet.getRangeByIndex(18, 7).setFormula('=E18*F18+(E18*F18)');
    // sheet.getRangeByIndex(19, 7).setFormula('=E19*F19+(E19*F19)');
    // sheet.getRangeByIndex(20, 7).setFormula('=E20*F20+(E20*F20)');
    // sheet.getRangeByIndex(15, 6, 20, 7).numberFormat = r'$#,##0.00';

    // sheet.getRangeByName('E15:G15').cellStyle.hAlign = HAlignType.right;
    // sheet.getRangeByName('B15:G15').cellStyle.fontSize = 10;
    // sheet.getRangeByName('B15:G15').cellStyle.bold = true;
    // sheet.getRangeByName('B16:G20').cellStyle.fontSize = 9;

    // sheet.getRangeByName('E22:G22').merge();
    // sheet.getRangeByName('E22:G22').cellStyle.hAlign = HAlignType.right;
    // sheet.getRangeByName('E23:G24').merge();

    // final Range range7 = sheet.getRangeByName('E22');
    // final Range range8 = sheet.getRangeByName('E23');
    // range7.setText('TOTAL');
    // range7.cellStyle.fontSize = 8;
    // range8.setFormula('=SUM(G16:G20)');
    // range8.numberFormat = r'$#,##0.00';
    // range8.cellStyle.fontSize = 24;
    // range8.cellStyle.hAlign = HAlignType.right;
    // range8.cellStyle.bold = true;

    sheet.getRangeByIndex(22 + data.length, 1).text =
        'Samir Jose Escobar Achury, 3148956413 | samirjoseescobar@hotmail.com';
    sheet.getRangeByIndex(22 + data.length, 1).cellStyle.fontSize = 8;

    final Range range9 = sheet.getRangeByName('A${22 + data.length}:H${23 + data.length}');
    range9.cellStyle.backColor = '#ACB9CA';
    range9.merge();
    range9.cellStyle.hAlign = HAlignType.center;
    range9.cellStyle.vAlign = VAlignType.center;

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    //Save and launch the file.
    await saveExcel(bytes, path);
  }

}