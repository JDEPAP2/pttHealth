import 'package:intl/intl.dart';

class Record {
  Record(this.numb, this.type, this.date, this.hour);

  //Day true, Night false
  final bool type;
  final double numb;
  final String date;
  final String hour;
  // final String date = DateFormat.yMd().format(DateTime.now());
  // final String hour = DateFormat.jm().format(DateTime.now());
  
}