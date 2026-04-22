import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final String labletext;
  final Function(String)? onchanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const CustomTextformfield({
    super.key,
    required this.labletext,
    this.onchanged,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onchanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
      ),
    );
  }
}
