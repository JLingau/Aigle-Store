import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  late CarouselController carouselController;
  int currentPage = 0;

  @override
  void initState() {
    carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
                autoPlay: true,
                height: 250,
                aspectRatio: 16 / 10,
                viewportFraction: 0.95,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPage = index;
                  });
                }),
            items: imageSliders,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imageList.length, (index) {
                bool isSelected = currentPage == index;
                return GestureDetector(
                  onTap: () {
                    carouselController.animateToPage(index);
                  },
                  child: AnimatedContainer(
                    width: isSelected ? 30 : 10,
                    height: 10,
                    margin:
                        EdgeInsets.symmetric(horizontal: isSelected ? 4 : 2),
                    decoration: BoxDecoration(
                        color: isSelected ? Colors.amber : Colors.black,
                        borderRadius: BorderRadius.circular(
                          40,
                        )),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  ),
                );
              })),
        ],
      ),
    );
  }
}

final List<Widget> imageSliders = imageList
    .map((item) => Container(
          margin: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Image.asset(
                        item['image'],
                        fit: BoxFit.cover,
                        width: 1000.0,
                      ),
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.5,
                          child: Container(
                            color: const Color(0xFF000000),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        item['description'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 11.0, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7.5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        item['button'],
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ))
    .toList();

final List<Map> imageList = [
  {
    'image': 'assets/images/carousel-slider1.jpg',
    'title': 'Get 10% Off',
    'description': 'For first purchase',
    'button': 'Register'
  },
  {
    'image': 'assets/images/carousel-slider2.jpg',
    'title': 'Virtual Try On',
    'description':
        'Chossing glasses online might be tricky, but now we have the features to make it easy. Try on your favorite frames with our virtual try on.',
    'button': 'Try Now'
  },
  {
    'image': 'assets/images/carousel-slider3.jpg',
    'title': '6.6 Day Sale',
    'description':
        'Discount up to 66% OFF for selected items and enjoy our product with the lower prices',
    'button': 'Shop Now'
  },
  {
    'image': 'assets/images/carousel-slider4.jpg',
    'title': 'Get 10% Off',
    'description': 'For first purchase',
    'button': 'Register'
  },
  {
    'image': 'assets/images/carousel-slider5.jpg',
    'title': 'Get 10% Off',
    'description': 'For first purchase',
    'button': 'Register'
  },
];
