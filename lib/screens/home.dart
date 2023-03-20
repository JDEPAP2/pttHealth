import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ptt_health/modal/addRegister.dart';
import 'package:ptt_health/modal/graph.dart';
import 'package:ptt_health/screens/showGraph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../class/record.dart';
import '../modal/graph.dart';
import 'package:intl/intl.dart';


class Home extends HookWidget {

  final List<Record> fileData;

  Home({required this.fileData});


  @override
  Widget build(BuildContext context) {
    final titles = (dark) => TextStyle(
        fontWeight: FontWeight.bold,
        color: dark ? Color.fromARGB(255, 26, 26, 26) : Colors.white);

    final data = useState(fileData);
    final test = useState('a');
    
    getDate({day = 1, month = 1}) {
      var days = [
        'Lunes',
        'Martes',
        'Miercoles',
        'Jueves',
        'Viernes',
        'Sabado',
        'Domingo'
      ];
      var months = [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto' 'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre'
      ];
      return {'day': days[day - 1], 'month': months[month - 1]};
    }
    getColor(number, sz){
      if(number<70)
        return Colors.blue[sz];
      if(number >= 70 && number <= 99)
        return Colors.green[sz];
      if(number >= 100 && number <= 125)
        return Colors.amber[sz];
      if(number>125)
        return Colors.red[sz];
        
      return Colors.white;
    }
    getGradient(number){
      if(number <70 && number > 0)
        return LinearGradient(colors: [Color.fromRGBO(21, 101, 192, 1), Color.fromRGBO(33, 150, 243, 1) ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      if(number >= 70 && number <= 99)
        return LinearGradient(colors: [Color.fromRGBO(46, 125, 50, 1), Color.fromRGBO(76, 175, 80, 1) ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      if(number >= 100 && number <= 125)
        return LinearGradient(colors: [Color.fromRGBO(255, 179, 0, 1), Color.fromRGBO(255, 213, 79, 1) ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      if(number>125)
        return LinearGradient(colors: [Color.fromRGBO(198, 40, 40, 1), Color.fromRGBO(244, 67, 54, 1) ], begin: Alignment.topLeft, end: Alignment.bottomRight);

      return LinearGradient(colors: [Color.fromARGB(255, 24, 24, 24), Color.fromARGB(255, 104, 104, 104) ], begin: Alignment.topLeft, end: Alignment.bottomRight);
    }
    isToday(date){
      return date == DateFormat.yMd().format(DateTime.now());
    }
    calculateToday(type){
      return List<Record>.of(data.value.where((r) => r.type == type && isToday(r.date)));
    }

    final List<Record> todayDay = calculateToday(true);
    final List<Record> todayNight = calculateToday(false);

    getColorsToday(){
      if(todayDay.isEmpty && todayNight.isEmpty){
        return getGradient(0);
      }
      if(todayDay.isNotEmpty && todayNight.isEmpty){
        return getGradient(todayDay[0].numb);
      }
      if(todayDay.isEmpty && todayDay.isNotEmpty){
        return getGradient(todayNight[0].numb);
      }
      if(todayDay.isNotEmpty && todayDay.isNotEmpty){
        return getGradient((todayDay[0].numb + todayNight[0].numb)/2);
      }
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 26, 110, 179),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => {},
          ),
          title: Text("Ptt Health", style: titles(false)),
          actions: [
            IconButton(
              icon: const Icon(Icons.auto_graph),
              onPressed: ()=>Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=> showGraph(data: data))),
            )
          ]),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: getColorsToday(),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 5,
                          offset: Offset(5, 5))
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 10, bottom: 25),
                          child: Column(children: [
                            Text(
                                '${test.value}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    height: 0)),
                            Text('${DateTime.now().day}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 100,
                                    height: 1)),
                            Text(
                                '${getDate(month: DateTime.now().month)['month']}',
                                style: const TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 40,
                                    height: 0.8))
                          ])),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.1)),
                        child: Column(children: [
                          Row(children: [
                            IconButton(
                              icon: const Icon(Icons.sunny),
                              onPressed: () => {},
                              color: Colors.white,
                            ),
                            Text( todayDay.isEmpty?': -- --':'${calculateToday(true)[0]}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    height: 0.75,
                                    fontWeight: FontWeight.bold))
                          ]),
                          Row(children: [
                            IconButton(
                              icon: const Icon(Icons.nightlight),
                              onPressed: () => {},
                              color: Colors.white,
                            ),
                            Text(todayNight.isEmpty?': -- --':calculateToday(true)[0].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    height: 0.75,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ]),
                      )
                    ]),
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
              child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 6, 53, 107),
                        Color.fromARGB(255, 3, 41, 97)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: Offset(5, 5))
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Registros Anteriores",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.1)),
                                  child:Column(
                                        children: [
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                               mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                data.value[i].type?IconButton(
                                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                                                  constraints: BoxConstraints(),
                                                  icon: const Icon( Icons.sunny,
                                                      size: 12),
                                                  onPressed: () => {},
                                                  color: getColor(data.value[i].numb, 200),
                                                  
                                                ):IconButton(
                                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                                                  constraints: BoxConstraints(),
                                                  icon: const Icon( Icons.dark_mode,
                                                      size: 12),
                                                  onPressed: () => {},
                                                  color: getColor(data.value[i].numb, 200)
                                                ),
                                                Text(':   ${data.value[i].numb} mg/dl',
                                                    style: TextStyle(
                                                        color: getColor(data.value[i].numb, 200),
                                                        fontSize: 12,
                                                        height: 1,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                IconButton(
                                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                                                  constraints: BoxConstraints(),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  icon: const Icon(
                                                      Icons.date_range,
                                                      size: 12),
                                                  onPressed: () => {},
                                                  color: getColor(data.value[i].numb, 200),
                                                ),
                                                Text(':   ${data.value[i].date}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: getColor(data.value[i].numb, 200),
                                                        fontSize: 12,
                                                        height: 1,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                IconButton(
                                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                                                  constraints: BoxConstraints(),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  icon: const Icon(
                                                      Icons.more_time,
                                                      size: 12),
                                                  onPressed: () => {},
                                                  color: getColor(data.value[i].numb, 200),
                                                ),
                                                Text(':   ${data.value[i].hour}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: getColor(data.value[i].numb, 200),
                                                        fontSize: 12,
                                                        height: 1,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]),
                                          
                                        ])
                                      ,
                                ));
                          },
                          itemCount: data.value.length < 10 ? data.value.length : 10),
                    ],
                  )))
        ],
      ),
      floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 26, 110, 179),
              child: const Icon(Icons.edit_document),
              onPressed: () {},
            ),
            Container(height: 10),
            FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 26, 110, 179),
              child: const Icon(Icons.add),
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                isScrollControlled: true,
                builder: (context) {
                  return AddRegister(data: data);
                },
              ),
            )
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
