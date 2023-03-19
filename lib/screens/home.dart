import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptt_health/modal/addRegister.dart';
import 'package:ptt_health/modal/graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../class/record.dart';
import '../modal/graph.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

    final titles = (dark) => TextStyle(
        fontWeight: FontWeight.bold,
        color: dark ? Color.fromARGB(255, 26, 26, 26) : Colors.white);
    final List<Record> data = [
      Record(70, true, "3/18/2023", "6:20"),
      Record(100, false, "3/18/2023", "12:20"),
      Record(90, true, "3/19/2023", "8:20"),
      Record(120, false, "3/19/2023", "1:40"),
      Record(70, true, "3/20/2023", "12:20"),
      Record(120, false, "3/20/2023", "12:20"),
      Record(90, true, "3/21/2023", "12:20"),
      Record(180, false, "3/21/2023", "12:20"),
      Record(80, true, "3/22/2023", "12:20"),
      Record(100, false, "3/22/2023", "12:20"),
      Record(70, true, "3/23/2023", "12:20"),
      Record(120, false, "3/24/2023", "12:20"),
      Record(90, true, "3/25/2023", "12:20"),
      Record(180, false, "3/26/2023", "12:20"),
      Record(80, true, "3/27/2023", "12:20"),
      Record(100, false, "3/28/2023", "12:20"),
    ];
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
              icon: const Icon(Icons.edit_document),
              onPressed: () => {},
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
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 24, 24, 24),
                      Color.fromARGB(255, 104, 104, 104)
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 10, bottom: 25),
                          child: Column(children: [
                            Text(
                                '${getDate(day: DateTime.now().weekday)['day']}',
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
                                    color: Colors.white,
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
                            Text(': -- --',
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
                            Text(': -- --',
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
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                        padding: EdgeInsets.symmetric(vertical: 20),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.1)),
                                  child: (data.length != i &&
                                          data[i].date == data[i + 1].date &&
                                          data[i].type &&
                                          data[i].date !=
                                              DateFormat.yMd()
                                                  .format(DateTime.now()))
                                      ? Column(children: [
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.sunny,
                                                      size: 17),
                                                  onPressed: () => {},
                                                  color: Colors.white,
                                                ),
                                                Text(': ${data[i].numb} mg/dl',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        height: 1.9,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                IconButton(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  icon: const Icon(
                                                      Icons.date_range,
                                                      size: 17),
                                                  onPressed: () => {},
                                                  color: Colors.white,
                                                ),
                                                Text(': ${data[i].date}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        height: 1.9,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                IconButton(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  icon: const Icon(
                                                      Icons.more_time,
                                                      size: 17),
                                                  onPressed: () => {},
                                                  color: Colors.white,
                                                ),
                                                Text(': ${data[i].hour}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        height: 1.9,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]),
                                          Row(children: [
                                            IconButton(
                                              icon: const Icon(Icons.nightlight,
                                                  size: 17),
                                              onPressed: () => {},
                                              color: Colors.white,
                                            ),
                                            Text(': ${data[i + 1].numb} mg/dl',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    height: 1.2,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            IconButton(
                                              alignment: Alignment.centerRight,
                                              icon: const Icon(Icons.date_range,
                                                  size: 17),
                                              onPressed: () => {},
                                              color: Colors.white,
                                            ),
                                            Text(': ${data[i + 1].date}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    height: 1.2,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            IconButton(
                                              alignment: Alignment.centerRight,
                                              icon: const Icon(Icons.more_time,
                                                  size: 17),
                                              onPressed: () => {},
                                              color: Colors.white,
                                            ),
                                            Text(': ${data[i + 1].hour}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    height: 1.2,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                        ])
                                      : null,
                                ));
                          },
                          itemCount: data.length < 10 ? data.length : 10),
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
                  return AddRegister();
                },
              ),
            )
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
