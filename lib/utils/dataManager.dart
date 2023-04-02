import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../class/record.dart';


class DataManager{

  List<Record> data = List<Record>.empty(growable: true);

  loadData() async{
    try { 
          String path= (await getApplicationDocumentsDirectory()).path;
          final File file = File('$path/Pttdata.txt');
          

          if(!(await file.exists())){
            file.writeAsString("");
            return data;
          }

          String content = await file.readAsString();
          List<String> lines = content.split(";");
          for (var element in lines) {
            if(element == ""){continue;}
            List<String> line = element.split(",");
            data.add(Record(double.parse(line[1]), line[2]=="true"?true:false, DateTime.parse(line[3])));
          }
          return data;
        // ignore: empty_catches
        } catch (e) {
          return data;
    }

  }

  writeData(data) async{
    try {
          String path= (await getApplicationDocumentsDirectory()).path;
          final File file = File('$path/Pttdata.txt');

          if(!(await file.exists())){
            file.writeAsString("");

          }

          String content = await file.readAsString();
          String res = "";
          data.forEach((element) {
            res += element.id.toString() + "," + element.numb.toString() + "," + element.type.toString() + "," + element.realDate.toString() + ";";
          });
          file.writeAsStringSync(res);

        // ignore: empty_catches
        } catch (e) {
          print("------------------------errrrrorrrr-----------------------------" + e.toString());
    }

  }

}