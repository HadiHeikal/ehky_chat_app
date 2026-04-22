import 'package:ehky_chat_app/shared/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAsktext extends StatelessWidget {
  final String asktext;
  final String text;
  final Function() onTap;
  const CustomAsktext({
    super.key,
    required this.text,
    required this.onTap,
    required this.asktext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(text: asktext, fontWeight: FontWeight.w500),

        GestureDetector(
          onTap: onTap,
          child: CustomText(
            text: text,
            fontWeight: FontWeight.w500,
            color: Color(0xff771F98),
          ),
        ),
      ],
    );
  }
}
