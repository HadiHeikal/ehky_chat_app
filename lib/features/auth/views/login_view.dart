import 'package:ehky_chat_app/core/constants/app_colors.dart';
import 'package:ehky_chat_app/core/utils/validators.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_asktext.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_button.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_textformfield.dart';
import 'package:ehky_chat_app/shared/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // form key
  final _formKey = GlobalKey<FormState>();
  // loading
  bool _isLoading = false;
  // Variables to hold Firebase Auth errors to display them under the text fields
  String? _firebaseEmailError;
  String? _firebasePasswordError;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Validate the form before attempting sign up
    if (!_formKey.currentState!.validate()) return;

    // show loding spinner
    setState(() => _isLoading = true);
    try {
      // Attempt to login user with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      // Navigate to home page
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      // Handle Firebase specific errors and map them to the corresponding UI fields
      setState(() {
        // login states
        if (e.code == 'user-not-found') {
          _firebaseEmailError = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          _firebasePasswordError = 'Wrong password provided for that user.';
        } else {
          _firebaseEmailError = e.message ?? 'An unknown error occurred.';
        }
      });
      // Re-trigger validation to show the Firebase errors immediately under the fields
      _formKey.currentState!.validate();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
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
                  CustomTextformfield(
                    labletext: 'Email',
                    controller: _emailController,
                    validator: (value) {
                      if (_firebaseEmailError != null) return _firebaseEmailError;
                      return Validators.email(value);
                    },
                    onChanged: (value) {
                      // Clear the Firebase error once the user starts typing again
                      if (_firebaseEmailError != null) {
                        setState(() => _firebaseEmailError = null);
                        _formKey.currentState?.validate();
                      }
                    },
                  ),
                  Gap(30),
                  Row(
                    children: [
                      Gap(15),
                      CustomText(text: 'Password'),
                    ],
                  ),
                  Gap(5),
                  CustomTextformfield(
                    labletext: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (_firebasePasswordError != null) return _firebasePasswordError;
                      return Validators.password(value);
                    },
                    onChanged: (value) {
                      // Clear the Firebase error once the user starts typing again
                      if (_firebasePasswordError != null) {
                        setState(() => _firebasePasswordError = null);
                        _formKey.currentState?.validate();
                      }
                    },
                  ),
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
                  CustomButton(
                    text: 'Login',
                    onTap: () {
                      _isLoading ? () {} : _login();
                    },
                  ),
                  Gap(20),
                  CustomAsktext(
                    asktext: 'Don\'t have an account?',
                    text: 'Sign up',
                    onTap: () => Navigator.pushNamed(context, 'signup'),
                  ),
                  ],
                ),
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
