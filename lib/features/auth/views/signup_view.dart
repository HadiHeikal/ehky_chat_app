import 'package:ehky_chat_app/core/utils/validators.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_asktext.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_button.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_lable.dart';
import 'package:ehky_chat_app/features/auth/widgets/custom_textformfield.dart';
import 'package:ehky_chat_app/shared/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  // Variables to hold Firebase Auth errors to display them under the text fields
  String? _firebaseEmailError;
  String? _firebasePasswordError;

  // dispose controllers
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles the sign-up flow using Firebase Authentication.
  Future<void> _signUp() async {
    // Reset any previous Firebase errors before validating
    setState(() {
      _firebaseEmailError = null;
      _firebasePasswordError = null;
    });

    // Validate the form before attempting sign up
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      // Attempt to create user with email and password
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      // Update display name for the newly created user
      await credential.user?.updateDisplayName(_nameController.text.trim());

      if (!mounted) return;

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      // Handle Firebase specific errors and map them to the corresponding UI fields
      setState(() {
        if (e.code == 'email-already-in-use') {
          _firebaseEmailError = 'This email is already registered.';
        } else if (e.code == 'invalid-email') {
          _firebaseEmailError = 'The email address is invalid.';
        } else if (e.code == 'weak-password') {
          _firebasePasswordError = 'The password provided is too weak.';
        } else {
          // Fallback error goes to email field as a generic spot
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
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
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

                    // Full Name
                    CustomLable(text: 'Full Name'),
                    Gap(5),
                    CustomTextformfield(
                      labletext: 'Full Name',
                      controller: _nameController,
                      validator: Validators.name, // Using centralized validator
                    ),
                    Gap(10),

                    // Email
                    CustomLable(text: 'Email Address'),
                    Gap(5),
                    CustomTextformfield(
                      labletext: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onchanged: (value) {
                        // Clear the Firebase error once the user starts typing again
                        if (_firebaseEmailError != null) {
                          setState(() => _firebaseEmailError = null);
                          _formKey.currentState?.validate();
                        }
                      },
                      validator: (value) {
                        // Display Firebase error if it exists, otherwise do standard validation
                        if (_firebaseEmailError != null) {
                          return _firebaseEmailError;
                        }
                        return Validators.email(value);
                      },
                    ),
                    Gap(10),

                    // Phone
                    CustomLable(text: 'Phone Number'),
                    Gap(5),
                    CustomTextformfield(
                      labletext: 'Phone Number',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator:
                          Validators.phone, // Using centralized validator
                    ),
                    Gap(10),

                    // Password
                    CustomLable(text: 'Password'),
                    Gap(5),
                    CustomTextformfield(
                      labletext: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      onchanged: (value) {
                        // Clear the Firebase error once the user starts typing again
                        if (_firebasePasswordError != null) {
                          setState(() => _firebasePasswordError = null);
                          _formKey.currentState?.validate();
                        }
                      },
                      validator: (value) {
                        // Display Firebase error if it exists, otherwise do standard validation
                        if (_firebasePasswordError != null) {
                          return _firebasePasswordError;
                        }
                        return Validators.password(value);
                      },
                    ),
                    Gap(10),

                    // Confirm Password
                    CustomLable(text: 'Confirm Password'),
                    Gap(5),
                    CustomTextformfield(
                      labletext: 'Confirm Password',
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) => Validators.confirmPassword(
                        value,
                        _passwordController.text,
                      ),
                    ),
                    Gap(30),

                    // Sign Up Button
                    CustomButton(
                      text: _isLoading ? 'Please wait...' : 'Sign Up',
                      onTap: _isLoading ? () {} : _signUp,
                    ),
                    Gap(20),
                    CustomAsktext(
                      asktext: 'Already have an account?',
                      text: ' Login',
                      onTap: () => Navigator.pop(context),
                    ),
                    Gap(20),
                  ],
                ),
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
