import 'package:ehky_chat_app/features/auth/widgets/custom_button.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_textformfield.dart';
import 'package:ehky_chat_app/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _SignupViewState();
}

class _SignupViewState extends State<LoginView> {
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
                  Gap(130),
                  CustomText(
                    text: 'Hello, Welcome Back',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(3),
                  CustomText(text: 'Happy to see you again, to use your'),
                  CustomText(text: 'account please login first.'),

                  Gap(30),
                  Row(
                    children: [
                      Gap(15),
                      CustomText(
                        text: 'Email Address',

                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Gap(5),
                  CustomTextformfield(labletext: 'Email'),
                  Gap(30),
                  Row(
                    children: [
                      Gap(15),
                      CustomText(text: 'Password'),
                    ],
                  ),
                  Gap(5),
                  CustomTextformfield(labletext: 'Password'),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        text: 'Forgot Password?',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff771F98),
                      ),
                      Gap(5),
                    ],
                  ),
                  Gap(50),
                  CustomButton(text: 'Login', onTap: () {}),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Don\'t have an account?',
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(5),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'signup'),
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
              top: 84,
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
