import 'package:ehky_chat_app/features/auth/widgets/custom_button.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_lable.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_textformfield.dart';
import 'package:ehky_chat_app/shared/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.arrow_left_circle,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                  Gap(10),
                  CustomText(
                    text: 'Create an account',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(3),
                  CustomText(text: 'Fill in the details below to create'),
                  CustomText(text: 'your new account.'),
                  Gap(30),
                  // full name
                  CustomLable(text: 'Full Name'),
                  Gap(5),
                  CustomTextformfield(labletext: 'Full Name'),
                  Gap(10),
                  // email
                  CustomLable(text: 'Email Address'),
                  Gap(5),
                  CustomTextformfield(labletext: 'Email Address'),
                  Gap(10),
                  // phone
                  CustomLable(text: 'Phone Number'),
                  Gap(5),
                  CustomTextformfield(labletext: 'Phone Number'),
                  Gap(10),
                  // password
                  CustomLable(text: 'Password'),
                  Gap(5),
                  CustomTextformfield(labletext: 'Password'),
                  Gap(10),
                  // confirm password
                  CustomLable(text: 'Confirm Password'),
                  Gap(5),
                  CustomTextformfield(labletext: 'Confirm Password'),
                  Gap(30),

                  CustomButton(text: 'Sign Up', onTap: () {}),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: 'Already have an account?'),

                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: CustomText(
                          text: 'Sign Up',
                          fontWeight: FontWeight.w500,
                          color: Color(0xff771F98),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 36,
              right: -36,
              child: Image.asset(
                'assets/images/login_image.png',
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
