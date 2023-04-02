
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../class/record.dart';

class PizzaGraph extends StatelessWidget {
  final ValueNotifier<List<Record>> data;
  PizzaGraph({required this.data});
  
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(3, 3)
              )]
              ),
            child: data.value.length != 0? SfCartesianChart(
            primaryXAxis: CategoryAxis(
              visibleMaximum: 3
            ),
            zoomPanBehavior: ZoomPanBehavior(  
              enablePanning: true,
              enablePinching: true,
              enableDoubleTapZooming: true
            ),
            title: ChartTitle(text: 'Nivel de azucar de Ptt',textStyle: TextStyle(fontWeight: FontWeight.bold)),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<Record, String>>[
                ColumnSeries<Record, String>(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                    dataSource: List<Record>.of(data.value.where((r) => r.type)),
                    xValueMapper: (Record r, _) => r.date,
                    yValueMapper: (Record r, _) => r.numb,
                    name: 'Ayuno',
                    gradient: LinearGradient(
                      colors: [Colors.amber, Colors.orange],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                    ),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      color: Colors.transparent,
                      labelAlignment: ChartDataLabelAlignment.middle,
                      textStyle: TextStyle(fontSize: 10, color: Colors.black26) 
                    )),
                ColumnSeries<Record, String>(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                    dataSource: List<Record>.of(data.value.where((r) => !r.type)),
                    xValueMapper: (Record r, _) => r.date,
                    yValueMapper: (Record r, _) => r.numb,
                    name: 'Noche',
                      gradient: LinearGradient(
                      colors: [Colors.blue, Color.fromARGB(255, 15, 109, 185)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                    ),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      color: Colors.transparent,
                      labelAlignment: ChartDataLabelAlignment.middle,
                      textStyle: TextStyle(fontSize: 10, color: Colors.white24) 
                    )),
            ]
          ): Text("No hay datos para mostrar")
      );
  }
  }