import 'package:aigle/providers/cart_provider.dart';
import 'package:aigle/utils/order_history.dart';
import 'package:aigle/utils/profile_detail.dart';
import 'package:aigle/utils/toast.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool loading = false;
  late String name = '';
  String address = '';
  int number = 0;

  ProfileDetail _profileDetail = ProfileDetail();
  final OrderHistory _orderHistory = OrderHistory();

  @override
  void initState() {
    super.initState();
    _profileDetail.getProfileData().then((value) {
      setState(() {
        name = value['name'];
        address = value['address'];
        number = value['phoneNumber'];
      });
    });
  }

  NumberFormat formatter =
      NumberFormat.currency(symbol: 'Rp. ', decimalDigits: 0, locale: 'id_ID');
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    var products = cart.items;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: products.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Delivery Address',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/profile_data');
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            color: Colors.black)),
                                    child: const Text(
                                      'Change Address',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    number != 0
                                        ? '${name.toUpperCase()} | +62${number.toString()}'
                                        : name.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(address.toUpperCase())
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Order Summary',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  var product = products[index];
                                  return Container(
                                    padding: const EdgeInsets.only(top: 7.5),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFC2C2C2),
                                                      width: 2,
                                                      style:
                                                          BorderStyle.solid)),
                                              child: Image(
                                                  image: NetworkImage(
                                                      product.image),
                                                  fit: BoxFit.fitWidth),
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product.name.toUpperCase(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  product.customization,
                                                  style: const TextStyle(
                                                    color: Color(0xFFC2C2C2),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Container(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .all(2),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFFC2C2C2),
                                                            width: 2,
                                                            style: BorderStyle
                                                                .solid)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              cart.removeQuantity(
                                                                  product);
                                                            });
                                                          },
                                                          icon: const Icon(
                                                              Icons.remove),
                                                          color: const Color(
                                                              0xFFC2C2C2),
                                                        ),
                                                        Text(
                                                          product.quantity
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              cart.addItem(
                                                                  product);
                                                            });
                                                          },
                                                          icon: const Icon(
                                                              Icons.add),
                                                          color: const Color(
                                                              0xFFC2C2C2),
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    cart.removeItem(product);
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.delete_forever_outlined,
                                                  color: Color(0xFFC2C2C2),
                                                  size: 30,
                                                ),
                                              ),
                                              Text(
                                                formatter.format(product.price *
                                                    product.quantity),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Subtotal',
                                style: TextStyle(color: Color(0xFF616161)),
                              ),
                              Text(
                                formatter.format(cart.getTotalPrice()),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              )
                            ],
                          ),
                          const SizedBox(height: 7.5),
                          const DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1,
                            dashLength: 4,
                            dashColor: Color.fromRGBO(97, 97, 97, .4),
                            dashGapLength: 4,
                          ),
                          const SizedBox(height: 7.5),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shipping Fee',
                                style: TextStyle(color: Color(0xFF616161)),
                              ),
                              Text(
                                'Free',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              )
                            ],
                          ),
                          const SizedBox(height: 7.5),
                          const DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1,
                            dashLength: 4,
                            dashColor: Color.fromRGBO(97, 97, 97, .4),
                            dashGapLength: 4,
                          ),
                          const SizedBox(height: 7.5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'TOTAL',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                formatter.format(cart.getTotalPrice()),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // ignore: unnecessary_null_comparison
                                  if (address.isEmpty || number == null) {
                                    Toast.alert(
                                        context,
                                        "Please enter valid address or number !",
                                        AlertType.success);
                                  } else {
                                    _orderHistory.setOrderHistory(context, products);
                                    Navigator.of(context).pushNamed('/payment_detail');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD4A056),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10)),
                                child: const Text(
                                  'Place Order',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Center(
                    child: Column(
                  children: [
                    const Text(
                      'Cart is empty, buy something !',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/products');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: const Color(0xFFD4A056),
                        ),
                        child: const Text(
                          'Go Back',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ))
                  ],
                )),
              ]));
  }
}
