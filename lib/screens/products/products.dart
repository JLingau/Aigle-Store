import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:aigle/models/product_model.dart';
import 'package:aigle/utils/product_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aigle/providers/cart_provider.dart';
import 'package:aigle/components/products/product_list.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final ProductService _productService = ProductService();
  User? userStatus = FirebaseAuth.instance.currentUser;
  final searchBar = TextEditingController();

  bool isSearching = false;
  bool isFiltered = false;
  List<ProductModel> _productsPlaceholder = [];
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _searchedProducts = [];
  List<ProductModel> _filteredSearchedProducts = [];

  int buttonActive = 1;
  int? allProductCount = 0;
  int? eyeglassProductCount = 0;
  int? sunglassProductCount = 0;

  Stream<List<ProductModel>> _loadProducts() {
    return _productService.getAllProducts();
  }

  void _loadSearchedProducts() {
    _productService.getAllProducts().listen((products) {
      setState(() {
        _productsPlaceholder = products;
        _searchedProducts = products;
        _filteredProducts = products;
        _filteredSearchedProducts = products;
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

  List<ProductModel> filteredProducts() {
    setState(() {
      if (buttonActive == 2) {
        _filteredProducts = _productsPlaceholder
            .where((product) => product.category.contains('eyeglasses'))
            .toList();
      } else if (buttonActive == 3) {
        _filteredProducts = _productsPlaceholder
            .where((product) => product.category.contains('sunglasses'))
            .toList();
      }
    });
    return _filteredProducts;
  }

  List<ProductModel> searchedAndFilteredProducts(String query) {
    setState(() {
      if (buttonActive == 2) {
        _filteredSearchedProducts = _productsPlaceholder
            .where((product) =>
                product.category.contains('eyeglasses') &&
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else if (buttonActive == 3) {
        _filteredSearchedProducts = _productsPlaceholder
            .where((product) =>
                product.category.contains('sunglasses') &&
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
    return _filteredSearchedProducts;
  }

  void setProductCount() {
    _productService.getAllProductsCount().then((value) {
      allProductCount = value;
    });
    _productService.getCategorizedProductsCount('sunglasses').then((value) {
      sunglassProductCount = value;
    });
    _productService.getCategorizedProductsCount('eyeglasses').then((value) {
      eyeglassProductCount = value;
    });
  }
    

  @override
  void initState() {
    super.initState();
    _loadSearchedProducts();
    setProductCount();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Products",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          actions: [
            userStatus != null
                ? badges.Badge(
                    badgeContent: Consumer<CartProvider>(
                      builder: (context, value, child) {
                        return Text(
                          value.getCounter().toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    position:
                        badges.BadgePosition.bottomStart(start: 20, bottom: 15),
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
                : Padding(
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
                        style:
                            TextStyle(color: Color(0xFFD4A056), fontSize: 14),
                      ),
                    ),
                  )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  onChanged: (query) {
                    setState(() {
                      if (searchBar.text.isNotEmpty) {
                        isSearching = true;
                        if (isFiltered) {
                          searchedAndFilteredProducts(query);
                        } else {
                          searchedProducts(query);
                        }
                      } else {
                        isSearching = false;
                      }
                    });
                  },
                  autocorrect: false,
                  controller: searchBar,
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            buttonActive = 1;
                            isFiltered = false;
                          });
                        },
                        style: buttonActive == 1
                            ? ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFd4a056),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))
                            : ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4a4c5c),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                        child: 
                        Text(
                          "All Glasses (${allProductCount.toString()})",
                          style: TextStyle(
                              color: buttonActive == 1
                                  ? const Color(0xFFffffff)
                                  : const Color(0xFFd4a056),
                              fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            buttonActive = 2;
                            isFiltered = true;
                            filteredProducts();
                          });
                        },
                        style: buttonActive == 2
                            ? ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFd4a056),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))
                            : ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4a4c5c),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          "Eye Glasses (${eyeglassProductCount.toString()})",
                          style: TextStyle(
                              color: buttonActive == 2
                                  ? const Color(0xFFffffff)
                                  : const Color(0xFFd4a056),
                              fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            buttonActive = 3;
                            isFiltered = true;
                            filteredProducts();
                          });
                        },
                        style: buttonActive == 3
                            ? ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFd4a056),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))
                            : ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4a4c5c),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          "Sunglasses (${sunglassProductCount.toString()})",
                          style: TextStyle(
                              color: buttonActive == 3
                                  ? const Color(0xFFffffff)
                                  : const Color(0xFFd4a056),
                              fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                isSearching && isFiltered
                    ? ProductList(products: _filteredSearchedProducts)
                    : isSearching
                        ? ProductList(products: _searchedProducts)
                        : isFiltered
                            ? ProductList(products: _filteredProducts)
                            : StreamBuilder<List<ProductModel>>(
                                stream: _loadProducts(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text('Something went wrong'),
                                    );
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Text('No products found'),
                                    );
                                  }
                                  final products = snapshot.data!;
                                  return ProductList(products: products);
                                },
                              )
              ],
            ),
          ),
        ));
  }
}

final List<Map> productList = [
  {
    'image': 'assets/images/products/chloe.jpg',
    'item': 'Chloe',
    'price': 150000
  },
  {
    'image': 'assets/images/products/brayden.jpg',
    'item': 'Brayden',
    'price': 199500
  },
  {
    'image': 'assets/images/products/rayban.jpg',
    'item': 'Rayban',
    'price': 450000
  },
  {
    'image': 'assets/images/products/louisvuitton.jpg',
    'item': 'Louis Vuitton',
    'price': 1500000
  },
  {
    'image': 'assets/images/products/gucci.jpg',
    'item': 'Gucci',
    'price': 5000000
  },
];
