import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptt_health/class/record.dart';
import 'package:ptt_health/modal/linearGraph.dart';
import 'package:ptt_health/modal/pizzaGraph.dart';
import 'package:ptt_health/modal/totalGraph.dart';
import '../utils/custom_text_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quickalert/quickalert.dart';
import '../screens/home.dart';

class showGraph extends HookWidget{

  final ValueNotifier<List<Record>> data;

  showGraph({required this.data});

    @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft
    ]);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 26, 110, 179),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: (){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home(fileData: data.value,)));
                });
                },)
          ,
          title: Text("Ptt Health", style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => {})
          ]),
      
      body: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            width: 600,
            padding: EdgeInsets.all(20),
            child: TotalGraph(data: data),
          ),
          Container(
            width: 600,
            padding: EdgeInsets.all(20),
            child: PizzaGraph(data: data),
          ),
          Container(
            width: 600,
            padding: EdgeInsets.all(20),
            child: LinearGraph(data: data),
          ),
        ])
        ,
    );
  }
}