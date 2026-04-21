import 'package:ehky_chat_app/shared/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff771F98),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        child: CustomText(
          text: text,
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
