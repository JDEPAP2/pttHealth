
import 'package:flutter/material.dart';
import 'package:ptt_health/class/record.dart';
import 'package:ptt_health/utils/dataManager.dart';
import '../utils/custom_text_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quickalert/quickalert.dart';
import 'home.dart';

class AddRegister extends HookWidget {

  final ValueNotifier<List<Record>> data;

  AddRegister({
    required this.data
  });



  @override
  Widget build(BuildContext context) {
    final day = useState(true);
    final night = useState(true);
    final number = useState(0.0);
    final temp = useState("");
    
    handleData(newData)async{
      await DataManager().writeData(newData);
      data.value = await DataManager().loadData();
    }

    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 70 / 100,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            physics: BouncingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 35 / 100,
                  margin: EdgeInsets.only(bottom: 20),
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              // header
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Añadir Registro',
                  style: TextStyle(
                      color: Color.fromARGB(255, 13, 57, 94),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'inter'),
                ),
              ),
              // Form
              CustomTextField(title: 'Valor Numerico de la glucosa', hint: '0-200',text: temp,),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Text(
                          'Jornada',
                          style: TextStyle(
                              color: Color.fromARGB(255, 42, 70, 92),
                              fontSize: 14),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                              width: 125,
                              height:50,
                              child: ElevatedButton(
                                  onPressed: day.value?() {
                                    day.value = !day.value;
                                    night.value = true;
                                  }: null,
                                  style: ElevatedButton.styleFrom(
                                      disabledBackgroundColor: Color.fromARGB(255, 75, 67, 44),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      primary:
                                          Color.fromARGB(255, 202, 148, 0)),
                                  child: Text('Ayuno',
                                      style: TextStyle(
                                          color: day.value?Colors.white:Colors.white38,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'inter')))),
                            Container(
                              margin: EdgeInsets.only(top: 10,right: 10, left: 10),
                              width: 125,
                              height:50,
                              child: ElevatedButton(
                                  onPressed: night.value?() {
                                    night.value = !night.value;
                                    day.value = true;
                                  }: null,
                                  style: ElevatedButton.styleFrom(
                                      disabledBackgroundColor: Color.fromARGB(255, 39, 45, 63),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      primary:
                                          Color.fromARGB(255, 15, 25, 56)),
                                  child: Text('Noche',
                                      style: TextStyle(
                                          color: night.value?Colors.white:Colors.white30,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'inter'))))
                        ],
                      ),)
                    ]),
              ),
              // Log in Button
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    try{
                      if(temp.value == ""){
                        QuickAlert.show(context: context, 
                          type: QuickAlertType.info,
                          title: "Digite un valor numerico"
                        );
                        return;
                      }
                      number.value = double.parse(temp.value);
                      if(60 <= number.value && number.value <= 300){
                        if (day.value && night.value){
                          QuickAlert.show(context: context, 
                            type: QuickAlertType.info,
                            title: "Seleccione la jornada en la que realizara el registro"
                          );
                          return;
                        }
                        
                        salir(){ 
                          List<Record> newL = List<Record>.of(data.value);
                          newL.add(Record(number.value, !day.value, DateTime.now()));
                          data.value = newL;
                          handleData(data.value);
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context)=> Home(fileData: data.value,)));
                        }

                        QuickAlert.show(context: context, 
                          type: QuickAlertType.success,
                          title: "Registro añadido exitosamente",
                          onCancelBtnTap: (){salir();},
                          onConfirmBtnTap: (){salir();}
                        );
                      }else{
                        QuickAlert.show(context: context, 
                          type: QuickAlertType.info,
                          title: "Solo numeros entre el 60 al 250"
                        );
                      }
                    }catch(e){
                      QuickAlert.show(context: context, 
                          type: QuickAlertType.error,
                          title: "Solo se permiten valores numericos"
                      );
                    }


                  },
                  child: Text('Añadir',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter')),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Color.fromARGB(255, 26, 110, 179),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
