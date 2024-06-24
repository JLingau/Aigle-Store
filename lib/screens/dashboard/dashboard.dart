import 'package:aigle/components/dashboard/home.dart';
import 'package:aigle/components/dashboard/orders.dart';
import 'package:aigle/components/dashboard/profile.dart';
import 'package:aigle/screens/products/products.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List menu = const [Home(), Products(), Orders(), Profile()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: menu[currentIndex],
        bottomNavigationBar: Container(
          height: 85,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                selectedItemColor: Colors.amber,
                unselectedItemColor: Colors.white,
                currentIndex: currentIndex,
                showUnselectedLabels: true,
                landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    backgroundColor: Color.fromRGBO(51, 60, 72, 1),
                    label: "Home"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.store),
                    backgroundColor: Color.fromRGBO(51, 60, 72, 1),
                    label: "Products"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.receipt_long),
                    backgroundColor: Color.fromRGBO(51, 60, 72, 1),
                    label: "Orders"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    backgroundColor: Color.fromRGBO(51, 60, 72, 1),
                    label: "Profile"
                  ),
                ],
              ),
            )));
  }
}
