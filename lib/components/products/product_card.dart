import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:aigle/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aigle/screens/products/products_detail.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  NumberFormat formatter = NumberFormat.decimalPatternDigits(locale: 'en_us');
  User? userStatus = FirebaseAuth.instance.currentUser;
  final ProductModel product;

  ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          userStatus != null
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductsDetail(product: product)))
              : Navigator.of(context).pushNamed('/login');
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3))
            ],
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 7.5),
              Text(
                product.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 7.5),
              Text(
                'Rp. ${formatter.format(product.price)}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
