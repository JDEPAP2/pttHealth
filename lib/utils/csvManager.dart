
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:open_file/open_file.dart';
import 'package:ptt_health/class/record.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


class CsvManager{
  final String fileName;
  final String path;

  CsvManager({required this.fileName, this.path = ""});

  saveCsv(List<Record>data) async{
    try{

        List<List<dynamic>> list = [['Fecha','Hora','Jornada','Valor','Nivel']];

        data.forEach((element) {
            String nivel= '';
            if(element.numb < 100 ){
              nivel = element.numb < 70? 'Bajo': 'Normal';
            }else{
              nivel = element.numb < 126? 'Prediabetes': 'Diabetes';
            }
           list.add([element.date,element.hour,element.type?'Ayunas':'Nocturna',element.numb, nivel]) ;
        });

        String csv = const ListToCsvConverter().convert(list);

        Directory directory = await path_provider.getApplicationSupportDirectory();
        String newPath = path == ''?'${directory.path}/$fileName':'$path/$fileName';
        File file = File(newPath);
        await file.writeAsString(csv);
        final result = await OpenFile.open(newPath);
        
    }catch(err){
      print(err);
    }
  }

}