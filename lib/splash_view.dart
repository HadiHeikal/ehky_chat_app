import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final bool onboardingCompleted =
        prefs.getBool('onboarding_completed') ?? false;

    if (mounted) {
      if (onboardingCompleted) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Navigator.pushReplacementNamed(context, 'onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8A34D9),
              Color(0xFF6B22A8), // Deep purple
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background circles
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),

            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                // Logo (splash screen logo) and title
                Image.asset(
                  'assets/images/Ehky_splash_logo.png',
                  width: 300,
                  height: 300,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.chat_bubble,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Subtitle
                const Text(
                  'Get Closer To EveryOne',
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),
                const Spacer(flex: 2),

                // Loading bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Loading...',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
