import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../class/record.dart';
import 'package:external_path/external_path.dart';


class dataManager{

  List<Record> data = List<Record>.empty(growable: true);

  loadData() async{
    try { 
          String path= (await getApplicationDocumentsDirectory()).path;
          print(path);
          final File file = File('$path/Pttdata.txt');
          
          print(await file.exists());

          if(!(await file.exists())){
            file.writeAsString("");
            return data;
          }

          String content = await file.readAsString();
          print(content);
          List<String> lines = content.split(";");
          for (var element in lines) {
            if(element == ""){continue;}
            List<String> line = element.split(",");
            data.add(Record(double.parse(line[1]), line[2]=="true"?true:false, DateTime.parse(line[3])));
          }
          print(data.length);
          return data;
        // ignore: empty_catches
        } catch (e) {
          print("-------ni lee----------" + e.toString());
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