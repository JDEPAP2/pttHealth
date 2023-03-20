


import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../class/record.dart';

class Graph extends StatelessWidget {
  final ValueNotifier<List<Record>> data;
  Graph({required this.data});
  
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black12),
            child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              visibleMaximum: 6
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
                LineSeries<Record, String>(
                    dataSource: List<Record>.of(data.value.where((r) => r.type)),
                    xValueMapper: (Record r, _) => r.date,
                    yValueMapper: (Record r, _) => r.numb,
                    name: 'Mañana',
                    color: Colors.amber,
                    dataLabelSettings: DataLabelSettings(isVisible: true, color: Colors.amber, labelAlignment: ChartDataLabelAlignment.middle)),
                LineSeries<Record, String>(
                    dataSource: List<Record>.of(data.value.where((r) => !r.type)),
                    xValueMapper: (Record r, _) => r.date,
                    yValueMapper: (Record r, _) => r.numb,
                    name: 'Noche',
                    color: Colors.indigo,
                    dataLabelSettings: DataLabelSettings(isVisible: true, color: Colors.indigo, labelAlignment: ChartDataLabelAlignment.middle))
            ]
          )
      );
  }
  }