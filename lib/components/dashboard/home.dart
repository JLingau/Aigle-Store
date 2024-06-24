import 'package:aigle/components/products/product_list.dart';
import 'package:aigle/models/product_model.dart';
import 'package:aigle/providers/cart_provider.dart';
import 'package:aigle/utils/product_service.dart';
import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ProductService _productService = ProductService();
  final searchBar = TextEditingController();
  late CarouselController carouselController;
  int currentPage = 0;
  bool isSearching = false;
  List<ProductModel> _productsPlaceholder = [];
  List<ProductModel> _searchedProducts = [];

  Stream<List<ProductModel>> _loadProducts() {
    return _productService.getAllProducts();
  }

  void _loadSearchedProducts() {
    _productService.getAllProducts().listen((products) {
      setState(() {
        _productsPlaceholder = products;
        _searchedProducts = products;
      });
    });
  }

  List<ProductModel> searchedProducts(String query) {
    setState(() {
      _searchedProducts = _productsPlaceholder
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
    return _searchedProducts;
  }

  @override
  void initState() {
    carouselController = CarouselController();
    super.initState();
    _loadSearchedProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: const Image(
          width: 125,
          image: AssetImage('assets/images/logo.png'),
        ),
        actions: <Widget>[
          FirebaseAuth.instance.currentUser == null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4A4C5C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Color(0xFFD4A056), fontSize: 14),
                    ),
                  ),
                )
              : Row(
                  children: [
                    badges.Badge(
                      badgeContent: Consumer<CartProvider>(
                        builder: (context, value, child) {
                          return Text(
                            value.getCounter().toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      position: badges.BadgePosition.bottomStart(
                          start: 20, bottom: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/cart');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(7.5),
                            color: const Color.fromRGBO(74, 76, 92, 1),
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    )
                  ],
                )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: <Widget>[
              TextField(
                autocorrect: false,
                controller: searchBar,
                onChanged: (query) {
                  if (searchBar.text.isNotEmpty) {
                    isSearching = true;
                    searchedProducts(query);
                  } else {
                    isSearching = false;
                  }
                },
                style: const TextStyle(fontSize: 14.0),
                decoration: InputDecoration(
                    hintText: "Search Product",
                    suffixIcon: const Icon(Icons.search),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ))),
              ),
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 10,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      currentPage = index;
                    }),
                items: imageSliders,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Products",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/products');
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(
                            color: Colors.amber,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.amber,
                            fontSize: 14),
                      ))
                ],
              ),
              isSearching
                  ? ProductList(products: _searchedProducts)
                  : StreamBuilder<List<ProductModel>>(
                      stream: _loadProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                          );
                        }
                        final products = snapshot.data!;
                        return ProductList(products: products);
                      },
                    )
            ],
          ),
        ),
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
