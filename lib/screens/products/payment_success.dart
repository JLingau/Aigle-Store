import 'package:flutter/material.dart';
import 'package:aigle/screens/dashboard/dashboard.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: height * .05,),
          Container(
            width: double.infinity,
            height: height * .2,
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
            child: const Image(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: height * .4,
            child: const Image(
              image: AssetImage('assets/images/success.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: height * .35,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Color(0xFF333C48),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                border: Border(
                    top: BorderSide(color: Color(0xFFD4A056), width: 4))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    'Payment Successful',
                    style: TextStyle(
                        color: Color(0xFFD4A056),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    'Your payment has been successfully processed. Thank you for shopping with us! Please allow 2-3 business days for processing and shipping.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Dashboard()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF333C48),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Color(0xFFD4A056), width: 1))),
                        child: const Text(
                          'Back To Home',
                          style:
                              TextStyle(color: Color(0xFFD4A056), fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Dashboard()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4A056),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: const Text(
                          'Check Order Status',
                          style:
                              TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
