import 'package:aigle/components/dashboard/address.dart';
import 'package:aigle/components/dashboard/cart.dart';
import 'package:aigle/components/dashboard/checkout.dart';
import 'package:aigle/components/dashboard/faq.dart';
import 'package:aigle/providers/cart_provider.dart';
import 'package:aigle/screens/authentication/forget_password.dart';
import 'package:aigle/screens/authentication/login.dart';
import 'package:aigle/screens/authentication/register.dart';
import 'package:aigle/screens/dashboard/dashboard.dart';
import 'package:aigle/screens/onboarding/onboarding.dart';
import 'package:aigle/screens/products/payment_detail.dart';
import 'package:aigle/screens/products/payment_success.dart';
import 'package:aigle/screens/products/products.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/dashboard",
        routes: {
          "/onboarding": (context) => const Onboarding(),
          "/products": (context) => const Products(),
          "/login": (context) => const Login(),
          "/register": (context) => const Register(),
          "/forget_password": (context) => const ForgetPassword(),
          "/dashboard": (context) => const Dashboard(),
          "/cart": (context) => const Cart(),
          "/profile_data": (context) => const Address(),
          "/checkout": (context) => const Checkout(),
          "/payment_detail": (context) => const PaymentDetail(),
          "/payment_success": (context) => const PaymentSuccess(),
          "/faq": (context) => const Faq()
        },
      ),
    );
  }
}
