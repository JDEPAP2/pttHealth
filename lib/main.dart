import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'class/record.dart';
import 'screens/home.dart';
import 'utils/dataManager.dart';

void main() {
  // ignore: prefer_const_constructors
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
  Widget body = CircularProgressIndicator( color:Colors.black);
  
  @override
  void initState() {
    getData();
    super.initState();
  }


  Future<Widget> getData() async
  {
    data = await DataManager().loadData();

    setState( ()=> body = MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Open Sans',
          scaffoldBackgroundColor: Colors.white,
        ),
        home: Home(fileData: data)));
    
    return body;

  }

  @override
  Widget build(BuildContext context) {
    return body;
  }
}
