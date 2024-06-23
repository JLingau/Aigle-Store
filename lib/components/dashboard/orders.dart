import 'package:aigle/models/order_model.dart';
import 'package:aigle/models/product_cart.dart';
import 'package:aigle/utils/order_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool isFiltered = false;
  int filteringCount = 1;
  User? userStatus = FirebaseAuth.instance.currentUser;
  final OrderHistory _orderHistory = OrderHistory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: userStatus != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    color: Colors.white,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              filteringCount = 1;
                              isFiltered = false;
                            });
                          },
                          child: Text(
                            'All',
                            style: TextStyle(
                                color: filteringCount == 1
                                    ? const Color(0xFFD4A056)
                                    : const Color(0xFF333C48),
                                decoration: filteringCount == 1
                                    ? TextDecoration.underline
                                    : null,
                                decorationColor: const Color(0xFFD4A056),
                                fontSize: 14),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              filteringCount = 2;
                              isFiltered = true;
                            });
                          },
                          child: Text(
                            'Unpaid',
                            style: TextStyle(
                                color: filteringCount == 2
                                    ? const Color(0xFFD4A056)
                                    : const Color(0xFF333C48),
                                decoration: filteringCount == 2
                                    ? TextDecoration.underline
                                    : null,
                                decorationColor: const Color(0xFFD4A056),
                                fontSize: 14),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              filteringCount = 3;
                              isFiltered = true;
                            });
                          },
                          child: Text(
                            'To Ship',
                            style: TextStyle(
                                color: filteringCount == 3
                                    ? const Color(0xFFD4A056)
                                    : const Color(0xFF333C48),
                                decoration: filteringCount == 3
                                    ? TextDecoration.underline
                                    : null,
                                decorationColor: const Color(0xFFD4A056),
                                fontSize: 14),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              filteringCount = 4;
                              isFiltered = true;
                            });
                          },
                          child: Text(
                            'Shipped',
                            style: TextStyle(
                                color: filteringCount == 4
                                    ? const Color(0xFFD4A056)
                                    : const Color(0xFF333C48),
                                decoration: filteringCount == 4
                                    ? TextDecoration.underline
                                    : null,
                                decorationColor: const Color(0xFFD4A056),
                                fontSize: 14),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              filteringCount = 5;
                              isFiltered = true;
                            });
                          },
                          child: Text(
                            'Complete',
                            style: TextStyle(
                                color: filteringCount == 5
                                    ? const Color(0xFFD4A056)
                                    : const Color(0xFF333C48),
                                decoration: filteringCount == 5
                                    ? TextDecoration.underline
                                    : null,
                                decorationColor: const Color(0xFFD4A056),
                                fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamBuilder<List<OrderModel>>(
                          stream: _orderHistory.getAllProducts(),
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
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text('No Order History found'),
                              );
                            }
                            final orders = snapshot.data!;
                            return OrdersContainer(orders: orders);
                          },
                        )
                      ],
                    ),
                  )
                ],
              )
            : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Login First !',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: const Color(0xFFD4A056),
                          ),
                          child: const Text(
                            'Login Now',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ))
                    ],
                  ),
            ));
  }
}

class OrdersContainer extends StatelessWidget {
  const OrdersContainer({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat.currency(
        symbol: 'Rp. ', decimalDigits: 0, locale: 'id_ID');
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        OrderModel order = orders[index];
        return Container(
            padding: const EdgeInsets.only(top: 7.5, left: 20, right: 20),
            color: Colors.white,
            width: double.infinity,
            child: ListView.builder(
              itemCount: order.orderItem.length,
              itemBuilder: (context, index) {
                ProductCart item = order.orderItem[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: const Color(0xFFC2C2C2),
                                  width: 2,
                                  style: BorderStyle.solid)),
                          child: Image(
                              image: NetworkImage(item.image),
                              fit: BoxFit.fitWidth),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.customization,
                              style: const TextStyle(
                                color: Color(0xFFC2C2C2),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.green),
                              child: Text(
                                order.status,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatter.format(item.price),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ));
      },
    );
  }
}
