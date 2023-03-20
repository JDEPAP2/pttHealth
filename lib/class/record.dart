import 'package:intl/intl.dart';
import 'package:objectid/objectid.dart';

class Record {
  
  Record(this.numb, this.type,this.realDate){
      date = DateFormat.yMd().format(realDate);
      hour = DateFormat.jm().format(realDate);
    }

  final ObjectId id = ObjectId();
  //Day true, Night false
  final bool type;
  final double numb;
  final DateTime realDate;
  String date = "";
  String hour = "";
  
}