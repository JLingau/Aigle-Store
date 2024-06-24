import 'package:aigle/components/onboarding/onboarding_content.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageController = PageController();
  int currentIndex = 0;
  int onboardingLength = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) => {
                setState(() {
                  currentIndex = value;
                })
              },
              children: [
                ...pages.map((e) {
                  return OnboardingContent(
                    e["image"], 
                    e["title"], 
                    e["description"], 
                    currentIndex, 
                    pageController);
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}

List<Map> pages = [
  {
  "image" : "assets/images/onboarding1.png",
  "title" : "Aigle",
  "description" : "Testing Out"
  },
  {
  "image" : "assets/images/onboarding2.png",
  "title" : "Virtual Try-On",
  "description" : "Testing Out"
  },
  {
  "image" : "assets/images/onboarding3.png",
  "title" : "Choose Yours",
  "description" : "Testing Out"
  },
];