import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ptt_health/screens/addRegister.dart';
import 'package:ptt_health/modal/registerList.dart';
import 'package:ptt_health/screens/downloadFile.dart';
import 'package:ptt_health/screens/showGraph.dart';
import '../class/record.dart';
import 'package:intl/intl.dart';
import '../utils/excelManager.dart';

class Home extends HookWidget {

  final List<Record> fileData;

  Home({required this.fileData});

  @override
  Widget build(BuildContext context) {
    final titles = (dark) => TextStyle(
        fontWeight: FontWeight.bold,
        color: dark ? Color.fromARGB(255, 26, 26, 26) : Colors.white);

    final data = useState(List<Record>.empty());
    data.value = fileData;
    print(fileData);

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
      if(todayDay.isEmpty && todayNight.isNotEmpty){
        return getGradient(todayNight[0].numb);
      }
      if(todayDay.isNotEmpty && todayDay.isNotEmpty){
        return getGradient((todayDay[0].numb + todayNight[0].numb)/2);
      }
    }
    print(data);
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 26, 110, 179),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.auto_graph),
              onPressed: (){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => showGraph(data: data)));});
                },
            )
          ,
          title: Text("Ptt Health", style: titles(false)),
          actions: [
            IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => {})
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
                                '${getDate(month: DateTime.now().month)['day']}',
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
                      todayDay.isNotEmpty || todayNight.isNotEmpty?Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.1)),
                        child: Column(children: [
                          todayDay.isNotEmpty?Row(
                            children: [
                              IconButton(
                              icon: const Icon(Icons.sunny),
                              onPressed: () => {},
                              color: Colors.white,
                            ),
                              Text(todayDay[0].numb.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    height: 0.75,
                                    fontWeight: FontWeight.bold))
                            ]):Row(),

                          todayNight.isNotEmpty?Row(children: [
                            IconButton(
                              icon: const Icon(Icons.nightlight),
                              onPressed: () => {},
                              color: Colors.white,
                            ),
                            Text(todayNight[0].numb.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    height: 0.75,
                                    fontWeight: FontWeight.bold))
                          ]):Row(),
                        ]),
                      ):Column()
                    ]),
              )),
              RegisterList(realData: data)
        ],
      ),
      floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "EditDocument",
              backgroundColor: Color.fromARGB(255, 26, 110, 179),
              child: const Icon(Icons.edit_document),
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                isScrollControlled: true,
                builder: (context) {
                  return DownloadFile(data: data);
                },
              ),
            ),
            Container(height: 10),
            FloatingActionButton(
              heroTag: "AddRegister",
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
