
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:open_file/open_file.dart';
import 'package:ptt_health/class/record.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


class TxtManager{
  final String fileName;
  final String path;

  TxtManager({required this.fileName, this.path = ""});

  saveTxt(List<Record>data) async{
    try{

        String res = "Fecha    \tHora        \tJornada      \tValor       \tNivel\n";

        data.forEach((element) {
          String type = element.type?'Ayunas':'Nocturna';
          String nivel= '';
          if(element.numb < 100 ){
            nivel = element.numb < 70? 'Bajo': 'Normal';
          }else{
            nivel = element.numb < 126? 'Prediabetes': 'Diabetes';
          }
          res += element.date.toString() + "\t" + element.hour.toString() + "     \t" + type + "       \t" + element.numb.toString() + "      \t" + nivel + "\n";
        });

        Directory directory = await path_provider.getApplicationSupportDirectory();
        String newPath = path == ''?'${directory.path}/$fileName':'$path/$fileName';
        File file = File(newPath);
        await file.writeAsString(res);
        final result = await OpenFile.open(newPath);
        
    }catch(err){
      print(err);
    }
  }

}