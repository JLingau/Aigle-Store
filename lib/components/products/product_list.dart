import 'package:flutter/material.dart';
import 'package:aigle/models/product_model.dart';
import 'package:aigle/components/products/product_card.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      padding: const EdgeInsets.all(5),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        childAspectRatio: 0.8,
        mainAxisSpacing: 20
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductModel product = products[index];
        return ProductCard(product);
      },
    );
  }
}
