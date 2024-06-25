import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnboardingContent extends StatelessWidget {
  String image;
  String title;
  String description;
  int currentIndex;
  var pageController = PageController();

  OnboardingContent(this.image, this.title, this.description, this.currentIndex,
      this.pageController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: 350,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100)),
                color: Color.fromRGBO(51, 60, 72, 1)),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    currentIndex <= 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextButton(
                                  child: const Text(
                                    "Skip",
                                    style: TextStyle(
                                        color: Color.fromRGBO(212, 160, 86, 1),
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Color.fromRGBO(212, 160, 86, 1)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed("/dashboard");
                                  },
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(212, 160, 86, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  child: const Text("Next",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed("/dashboard");
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(212, 160, 86, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  child: const Text("Get Started",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
