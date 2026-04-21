import 'package:ehky_chat_app/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class CustomLable extends StatelessWidget {
  final String text;
  const CustomLable({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(20),
        CustomText(text: text),
      ],
    );
  }
}
