import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ptt_health/screens/editRegister.dart';
import '../class/record.dart';


class RegisterList extends HookWidget {

  final ValueNotifier<List<Record>> realData;


  RegisterList({
    required this.realData
  });

  @override
  Widget build(BuildContext context) {

    final data = useState(List<Record>.from(realData.value));
    final order = useState(true);
    final orderIcon = useState(Icons.arrow_downward_outlined);  

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

    return Container(
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
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child:
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "Registros Anteriores",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                            splashColor: Colors.white,
                            onTap: (){
                              if(order.value){
                                orderIcon.value = Icons.arrow_downward_outlined;
                                data.value.sort((a,b)=> a.realDate.compareTo(b.realDate));
                              }else{
                                orderIcon.value = Icons.arrow_upward_rounded;
                                data.value.sort((a,b)=> b.realDate.compareTo(a.realDate));
                              }
                              order.value = !order.value;
                            },
                            child:                          
                            Container(
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            child: Icon(orderIcon.value, color: Colors.white,),
                          ) 
                          )
                        ],
                      ),
                      ),
                      ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return InkWell(                              
                              hoverColor: Colors.white,
                              splashColor: Colors.white,
                              onTap: (){
                                  showModalBottomSheet(context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder:(BuildContext context){
                                    return Container(
                                      child: EditRegister(data: data, index: i),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                    );
                                  });
                                },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 3),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
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
                                ))
                            );
                          },
                          itemCount: data.value.length),
                    ],
                  )));
  }
}









