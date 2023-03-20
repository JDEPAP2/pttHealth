import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'class/record.dart';
import 'screens/home.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  List<Record> data = List<Record>.empty();

  @override
  void initState() {
    super.initState();
    _loadData();

  }

  _loadData() async{
    Permission.manageExternalStorage.request();
    if(await Permission.manageExternalStorage.status.isDenied){
      return;
    }

    try {      
          final File file = File("./data/data.txt");
          String content = await file.readAsString();
          List<String> lines = content.split(";");
          lines.forEach((element) {
            List<String> line = element.split(",");
            data.add(Record(double.parse(line[1]), line[2]=="true"?true:false, DateTime.parse(line[3])));
          });
          return;
        // ignore: empty_catches
        } catch (e) {
        }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Open Sans',
          scaffoldBackgroundColor: Colors.white,
        ),
        home: Home(fileData: data,));
  }
}
