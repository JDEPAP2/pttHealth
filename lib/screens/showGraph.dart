import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptt_health/class/record.dart';
import 'package:ptt_health/modal/graph.dart';
import '../utils/custom_text_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quickalert/quickalert.dart';
import '../screens/home.dart';

class showGraph extends StatelessWidget{

  final List<Record> data;

  showGraph({required this.data});

    @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft
    ]);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: Graph(data: data),
          )
        ])
        ,
    );
  }
}