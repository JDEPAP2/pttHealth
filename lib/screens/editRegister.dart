
import 'package:flutter/material.dart';
import 'package:ptt_health/class/record.dart';
import 'package:ptt_health/utils/dataManager.dart';
import '../utils/custom_text_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quickalert/quickalert.dart';
import 'home.dart';

class EditRegister extends HookWidget {

  final ValueNotifier<List<Record>> data;
  final int index;


  EditRegister({
    required this.data,
    required this.index
  });



  @override
  Widget build(BuildContext context) {
    
    final item = useState(data.value[index]);
    final day = useState(item.value.type);
    final number = useState(item.value.numb);
    final temp = useState(item.value.numb.toString());
    final controller = TextEditingController.fromValue(
      TextEditingValue(
        text:temp.value, 
        selection: TextSelection.collapsed(
          offset: temp.value.length)));
    
    handleData(newData)async{
      await DataManager().writeData(newData);
      data.value = await DataManager().loadData();
    }


    salir(){
      handleData(data.value);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context)=> Home(fileData: data.value,)));
    }

    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 70 /100,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
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
                  'Editar Registro',
                  style: TextStyle(
                      color: Color.fromARGB(255, 13, 57, 94),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'inter'),
                ),
              ),
              // Form
              CustomTextField(title: 'Valor Numerico de la glucosa', hint: '0-200', text: temp, controller: controller),
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8, top: 10),
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
                                  onPressed: !day.value?() {
                                    day.value = !day.value;
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
                                          color: !day.value?Colors.white:Colors.white38,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'inter')))),
                            Container(
                              margin: EdgeInsets.only(top: 10,right: 10, left: 10),
                              width: 125,
                              height:50,
                              child: ElevatedButton(
                                  onPressed: day.value?() {
                                    day.value = !day.value;
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
                                          color: day.value?Colors.white:Colors.white30,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'inter'))))
                        ],
                      ),)
                    ]),
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
              Container(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 7),
                width: 150,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    data.value.removeWhere((element) => element.id == item.value.id);
                    salir();
                  },
                  child: Text('Eliminar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter')),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Color.fromARGB(255, 179, 26, 26),
                ),
              )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 7),
                width: 150,
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

                        item.value.numb = number.value;
                        item.value.type = day.value;

                        data.value[index] = item.value;

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
                  child: Text('Guardar',
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
              ])
            ],
          ),
        )
      ],
    );
  }
}
