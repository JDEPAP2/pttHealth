import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ptt_health/class/record.dart';
import 'package:ptt_health/screens/home.dart';
import 'package:ptt_health/utils/csvManager.dart';
import 'package:ptt_health/utils/custom_text_field.dart';
import 'package:ptt_health/utils/excelManager.dart';
import 'package:ptt_health/utils/txtManager.dart';
import 'package:quickalert/quickalert.dart';

class DownloadFile extends HookWidget {

  final ValueNotifier<List<Record>> data;

  DownloadFile({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final temp = useState("");
    final selection = useState("Excel");
    final fileName = useState("");
    final List listF = ['Excel','CSV','Texto'];

    salir(){
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
                  'Exportar Datos',
                  style: TextStyle(
                      color: Color.fromARGB(255, 13, 57, 94),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'inter'),
                ),
              ),
              
              CustomTextField(title: 'Escribe el nombre del archivo', hint: 'Escribe un nombre', text: temp),
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 5),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  'Tipo de Archivo',
                  style: TextStyle(
                      color: Color.fromARGB(255, 42, 70, 92),
                      fontSize: 14),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(80, 141, 161, 179),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(8),
                  isExpanded: true,
                  focusColor: Colors.transparent,
                value: selection.value,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Color.fromARGB(255, 13, 57, 94)),
                underline: Container(
                  height: 0,
                  color: Colors.transparent,
                ),
                onChanged: (String? value) {
                  selection.value = '$value';
                },
                items: listF.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ),
Container(
                margin: EdgeInsets.only(top: 30, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    if(temp.value == ""){
                        QuickAlert.show(context: context, 
                          type: QuickAlertType.error,
                          title: "El archivo debe tener un nombre"
                        );
                        return;
                    }

                    Future<String?> selectedDirectory = FilePicker.platform.getDirectoryPath();
                    selectedDirectory.then((value){

                      List<Record> exportData = List<Record>.from(data.value);

                      exportData.sort((a,b)=> a.realDate.compareTo(b.realDate));

                      if(selection.value == 'Excel'){
                        fileName.value = '${temp.value}.xlsx';
                        ExcelManager(fileName: fileName.value, data: exportData).generateExcel(path: value==null?'':value);
                      }else{
                        if(selection.value == 'CSV'){
                          fileName.value = '${temp.value}.csv';
                          CsvManager(fileName: fileName.value, path: value==null?'':value ).saveCsv(exportData);
                        }else{
                          fileName.value = '${temp.value}.txt';
                          TxtManager(fileName: fileName.value, path: value==null?'':value).saveTxt(exportData);
                        }
                      }
                      QuickAlert.show(context: context, 
                          type: QuickAlertType.success,
                          title: "Registro añadido exitosamente",
                          onCancelBtnTap: (){salir();},
                          onConfirmBtnTap: (){salir();}
                        );
                    });
                  },

                  child: Text('Exportar',
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
              ]),
        )
      ],
    );
  }
}