import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:aigle/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:aigle/models/product_cart.dart';
import 'package:aigle/models/product_model.dart';
import 'package:aigle/providers/cart_provider.dart';

class ProductsDetail extends StatefulWidget {
  final ProductModel product;

  const ProductsDetail({super.key, required this.product});

  @override
  State<ProductsDetail> createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {
  int addonButton = 1;
  int currentPrice = 0;
  String customizable = '';
  bool isCustomized = false;

  NumberFormat formatter =
      NumberFormat.currency(symbol: 'Rp. ', decimalDigits: 0, locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Image(
                    image: NetworkImage(widget.product.imageUrl),
                    fit: BoxFit.fitWidth),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            formatter.format(widget.product.price),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Lens Type',
                        style:
                            TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 2.5),
                          scrollDirection: Axis.horizontal,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  addonButton = 1;
                                  currentPrice = widget.product.price;
                                  isCustomized = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: addonButton == 1
                                      ? const Color(0xFFD4A056)
                                      : const Color(0xFF333C48)),
                              child: Text(
                                'Clear Lenses  Rp.0',
                                style: TextStyle(
                                    color: addonButton == 1
                                        ? Colors.white
                                        : const Color(0xFFD4A056),
                                    fontSize: 13),
                              ),
                            ),
                            const SizedBox(width: 7.5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  addonButton = 2;
                                  currentPrice = widget.product.price + 29000;
                                  isCustomized = true;
                                  customizable = 'Photocromic';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: addonButton == 2
                                      ? const Color(0xFFD4A056)
                                      : const Color(0xFF333C48)),
                              child: Text(
                                'Photocromic  Rp.29.000',
                                style: TextStyle(
                                    color: addonButton == 2
                                        ? Colors.white
                                        : const Color(0xFFD4A056),
                                    fontSize: 13),
                              ),
                            ),
                            const SizedBox(width: 7.5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  addonButton = 3;
                                  currentPrice = widget.product.price + 29000;
                                  isCustomized = true;
                                  customizable = 'Anti Radiation';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: addonButton == 3
                                      ? const Color(0xFFD4A056)
                                      : const Color(0xFF333C48)),
                              child: Text(
                                'Anti Radiation  Rp.29.000',
                                style: TextStyle(
                                    color: addonButton == 3
                                        ? Colors.white
                                        : const Color(0xFFD4A056),
                                    fontSize: 13),
                              ),
                            ),
                            const SizedBox(width: 7.5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  addonButton = 4;
                                  currentPrice = widget.product.price + 29000;
                                  isCustomized = true;
                                  customizable = 'Anti UV';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: addonButton == 4
                                      ? const Color(0xFFD4A056)
                                      : const Color(0xFF333C48)),
                              child: Text(
                                'Anti UV  Rp.29.000',
                                style: TextStyle(
                                    color: addonButton == 4
                                        ? Colors.white
                                        : const Color(0xFFD4A056),
                                    fontSize: 13),
                              ),
                            ),
                            const SizedBox(width: 7.5),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(widget.product.description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF979797),
                            fontSize: 16,
                          )),
                    ],
                  )),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
                color: Color(0xFF333C48), shape: BoxShape.rectangle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      currentPrice == 0
                          ? formatter.format(widget.product.price)
                          : formatter.format(currentPrice),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      cart.addItem(ProductCart(
                          id: widget.product.id,
                          name: widget.product.name,
                          description: widget.product.description,
                          image: widget.product.imageUrl,
                          customization: isCustomized ? customizable : '',
                          price: currentPrice == 0
                              ? widget.product.price
                              : currentPrice,
                          quantity: 1));
                      Toast.alert(
                        context,
                        "Added to cart",
                        AlertType.success,
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.5)),
                        backgroundColor: const Color(0xFFD4A056),
                        padding: EdgeInsets.symmetric(vertical: 10)),
                    label: const Text(
                      'Add To Cart',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
