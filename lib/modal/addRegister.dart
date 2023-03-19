import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';

class AddRegister extends StatelessWidget {
  bool day = true;
  bool night = true;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 85 / 100,
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
              CustomTextField(title: 'Numero', hint: '0-200'),
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8, top: 10),
                        child: Text(
                          'Periodo',
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
                              width: 200,
                              height:50,
                              child: ElevatedButton(
                                  onPressed: day?() {
                                    day = !day;
                                    night = true;
                                  }: null,
                                  style: ElevatedButton.styleFrom(
                                      disabledBackgroundColor: Color.fromARGB(255, 75, 67, 44),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      primary:
                                          Color.fromARGB(255, 202, 148, 0)),
                                  child: Text('Mañana',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'inter')))),
                            Container(
                              margin: EdgeInsets.only(top: 10,right: 10, left: 10),
                              width: 200,
                              height:50,
                              child: ElevatedButton(
                                  onPressed: () => {},
                                  style: ElevatedButton.styleFrom(
                                      disabledBackgroundColor: Color.fromARGB(255, 39, 45, 63),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      primary:
                                          Color.fromARGB(255, 15, 25, 56)),
                                  child: Text('Noche',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'inter'))))
                        ],
                      ),)
                    ]),
              ),
              // Log in Button
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Text("")));
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
