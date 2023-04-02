import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hint;
  final bool obsecureText;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final ValueNotifier<String> text;
  final TextEditingController? controller;

  CustomTextField({
    required this.title,
    required this.hint,
    required this.text,
    this.controller,
    this.obsecureText = false,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              '$title',
              style: TextStyle(color: Color.fromARGB(255, 42, 70, 92), fontSize: 14),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                color: Color.fromARGB(80, 141, 161, 179),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (value) => text.value = value,
              textInputAction: TextInputAction.done,
              controller: controller,
              style: TextStyle(fontSize: 14),
              cursorColor: Color.fromARGB(255, 26, 110, 179),
              obscureText: obsecureText,
              decoration: InputDecoration(
                hintText: '$hint',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                contentPadding: EdgeInsets.only(left: 16),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
