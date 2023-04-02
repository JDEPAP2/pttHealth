import 'package:intl/intl.dart';
import 'package:objectid/objectid.dart';

class Record {
  
  Record(this.numb, this.type,this.realDate){
      date = DateFormat.yMd().format(realDate);
      hour = DateFormat.jm().format(realDate);
    }

  ObjectId id = ObjectId();
  //Day true, Night false
  bool type;
  double numb;
  DateTime realDate;
  String date = "";
  String hour = "";
  
}