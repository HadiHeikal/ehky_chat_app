import 'package:ehky_chat_app/features/auth/views/login_view.dart';
import 'package:ehky_chat_app/features/auth/views/signup_view.dart';
import 'package:ehky_chat_app/features/home/views/home_root_view.dart';
import 'package:ehky_chat_app/features/onboarding/onboarding_screen.dart';
import 'package:ehky_chat_app/splash_view.dart';
import 'package:flutter/material.dart';

class EhkyApp extends StatelessWidget {
  const EhkyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ehky Chat App',
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashView(),
        'onboarding': (context) => const OnboardingScreen(),
        'login': (context) => const LoginView(),
        'signup': (context) => const SignupView(),
        'home': (context) => const HomeRootView(),
      },
    );
  }
}
