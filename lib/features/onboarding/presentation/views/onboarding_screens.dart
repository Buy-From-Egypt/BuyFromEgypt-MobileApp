import 'package:flutter/material.dart';
import 'package:buy_from_egypt/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:buy_from_egypt/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:buy_from_egypt/features/onboarding/presentation/widgets/onboarding_bottom_section.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Connect, Trade, and Grow",
      "description":
          "Your gateway to seamless global trade and professional networking. Discover trusted partners, list products, and manage your business—all in one place.",
      "image": "assets/images/undraw_connecting-teams_nnjy 1.svg",
    },
    {
      "title": "Let's Tailor Your Journey",
      "description":
          "Choose your role, industry, and preferences to unlock a personalized experience and maximize your success.",
      "image": "assets/images/undraw_advanced-customization_7ms4.svg",
    },
    {
      "title": "Discover Trusted Suppliers",
      "description":
          "No more guesswork! Access a global marketplace of verified suppliers, negotiate the best deals, and import with confidence.",
      "image": "assets/images/undraw_map_cuix 1.svg",
    }
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OnboardingAppBar(
            currentPage: _currentPage,
            pageController: _pageController,
            onboardingDataLength: onboardingData.length,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => OnboardingContent(
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
                image: onboardingData[index]["image"]!,
              ),
            ),
          ),
          OnboardingBottomSection(
            currentPage: _currentPage,
            pageController: _pageController,
            onboardingDataLength: onboardingData.length,
          ),
        ],
      ),
    );
  }
}
