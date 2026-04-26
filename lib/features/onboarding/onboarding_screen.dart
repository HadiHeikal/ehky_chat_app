import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Get Closer To EveryOne",
      "subtitle": "Helps you to contact everyone with just easy way",
      "image": "assets/images/onboarding_1.png",
      "button": "getting Started",
      "bottomButton": "Skip Intro",
    },
    {
      "title": "Connect Instantly",
      "subtitle":
          "Chat with friends and family in real-time. Ehky makes every conversation feel closer.",
      "image": "assets/images/onboarding_connect.png",
      "button": "Next",
      "bottomButton": "Skip intro",
    },
    {
      "title": "Private & Secure",
      "subtitle":
          "End-to-end encrypted messages so only you and your contacts can read what's sent.",
      "image": "assets/images/onboarding_privacy.png",
      "button": "Next",
      "bottomButton": "Skip intro",
    },
    {
      "title": "Share Everything",
      "subtitle":
          "Share photos, videos, voice messages and files with anyone - instantly.",
      "image": "assets/images/onboarding_media.png",
      "button": "Get Started",
      "bottomButton": "I have an account",
    },
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    if (mounted) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  void _nextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    title: onboardingData[index]["title"]!,
                    subtitle: onboardingData[index]["subtitle"]!,
                    image: onboardingData[index]["image"]!,
                    isFirstPage: index == 0,
                  );
                },
              ),
            ),
            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index, context),
              ),
            ),
            const SizedBox(height: 30),
            // Main Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF7B2CBF,
                  ), // Purple color from design
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  onboardingData[_currentIndex]["button"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Bottom Button (Skip / I have an account)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _currentIndex == onboardingData.length - 1
                  ? OutlinedButton(
                      onPressed: _completeOnboarding,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: const BorderSide(color: Color(0xFF7B2CBF)),
                      ),
                      child: Text(
                        onboardingData[_currentIndex]["bottomButton"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7B2CBF),
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: _completeOnboarding,
                      child: Text(
                        onboardingData[_currentIndex]["bottomButton"]!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: _currentIndex == index ? 24 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentIndex == index
            ? const Color(0xFF7B2CBF)
            : Colors.grey.shade300,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final bool isFirstPage;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.isFirstPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isFirstPage) ...[
            // Layout for the first page: Text top, Image bottom
            const SizedBox(height: 40),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  image,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image, size: 150, color: Colors.grey),
                ),
              ),
            ),
          ] else ...[
            // Layout for screens 2,3,4: Image top, Text bottom
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFE2D4F0),
                          const Color(0xFFE2D4F0).withOpacity(0.0),
                        ],
                        stops: const [0.4, 1.0],
                      ),
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        image,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.image,
                              size: 100,
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
