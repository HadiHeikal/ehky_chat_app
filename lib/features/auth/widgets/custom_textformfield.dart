import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final String labletext;
  const CustomTextformfield({super.key, required this.labletext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Color(0xff6B6B6B),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: TextStyle(color: Color(0xff6B6B6B)),
        labelText: labletext,
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff6B6B6B), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff6B6B6B), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
      ),
    );
  }
}
