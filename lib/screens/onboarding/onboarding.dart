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
  "description" : "AIGLE is eyewear store application that give an amazing experience purchasing your own style of your eyewear. AIGLE will give guarantee for who don’t satisfy after using our products."
  },
  {
  "image" : "assets/images/onboarding2.png",
  "title" : "Virtual Try-On",
  "description" : "Experience the future of eyewear shopping with our virtual try-on feature! Try on hundreds of stylish frames from the comfort of your own home."
  },
  {
  "image" : "assets/images/onboarding3.png",
  "title" : "Choose Yours",
  "description" : "You can customize the color and style of their glasses, creating a unique and personalized look. Choose and create the new style that suitable for you."
  },
];