
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../class/record.dart';

class TotalGraph extends StatelessWidget {
  final ValueNotifier<List<Record>> data;
  
  TotalGraph({required this.data});
  
  @override
  Widget build(BuildContext context) {
    List<Record> sortData = List<Record>.from(data.value);
    sortData.sort((a,b){
      if(a.date == b.date){
        return b.numb.compareTo(a.numb);
      }
      return a.realDate.compareTo(b.realDate);
    });

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
                    dataSource: sortData,
                    xValueMapper: (Record r, _) => r.date,
                    yValueMapper: (Record r, _) => r.numb,
                    name: 'Registros',
                    pointColorMapper: (datum, index){
                      double number = datum.numb;
                          if(number<70)
                            return Colors.blue;
                          if(number >= 70 && number <= 99)
                            return Colors.green;
                          if(number >= 100 && number <= 125)
                            return Colors.amber;
                          if(number>125)
                            return Colors.red;
                    },
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      color: Colors.transparent,
                      labelAlignment: ChartDataLabelAlignment.middle,
                      textStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold) 
                    )),
            ]
          ): Text("No hay datos para mostrar")
      );
  }
  }