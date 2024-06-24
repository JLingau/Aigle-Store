import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:aigle/providers/cart_provider.dart';

class PaymentDetail extends StatefulWidget {
  const PaymentDetail({super.key});

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  NumberFormat formatter =
      NumberFormat.currency(symbol: 'Rp. ', decimalDigits: 0, locale: 'id_ID');
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now().add(const Duration(hours: 12));
    String formattedDate = DateFormat('MMMM dd, yyyy, hh:mm aaa').format(time);
    var cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Complete Payment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Pay before $formattedDate',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              height: 75,
              width: 75,
              margin: const EdgeInsets.only(bottom: 5),
              child: const Image(
                image: AssetImage('assets/images/BCA.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            const Text(
              'BCA Virtual Account',
              style: TextStyle(color: Color(0xFF979797), fontSize: 15),
            ),
            const Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                '0016237013813328',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: DottedLine(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                lineLength: double.infinity,
                lineThickness: 1,
                dashLength: 4,
                dashColor: Color.fromRGBO(97, 97, 97, .4),
                dashGapLength: 4,
              ),
            ),
            const Text('Total Payment',
                style: TextStyle(color: Color(0xFF979797), fontSize: 15)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                formatter.format(cart.getTotalPrice()),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Payment Guide via ATM Transfer',
                      style: TextStyle(color: Color(0xFF7A7A7A)),
                    ),
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Text(
                          '1. Enter your ATM card and PIN at the BCA ATM\n2. Select Cash Withdrawal/Other Transactions\n3. Select Other Transactions\n4. Select Transfer\n5. Select the menu Go to BCA Virtual Account Account\n6. Enter the BCA Virtual Account number and click Correct\n7. Check the transaction details and select Yes\n8. Transaction successful',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Payment Guide via BCA Mobile',
                      style: TextStyle(color: Color(0xFF7A7A7A)),
                    ),
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Text(
                          '1. Log in to BCA mobile\n2. Select m-Transfer and select BCA Virtual Account\n3. Enter the Virtual Account number of the e-commerce and click Send\n4. Enter the amount\n5. Review the transaction details, click OK\n6. Enter your PIN and transaction is successful',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Payment Guide via KlikBCA',
                      style: TextStyle(color: Color(0xFF7A7A7A)),
                    ),
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Text(
                          '1. Log in to KlikBCA\n2. Select Fund Transfer and select “Transfer to BCA Virtual Account\n3. Enter the Virtual Account number of the e-commerce and click Continue\n4. Enter the amount and click Continue\n5. Enter the KeyBCA Appli 1 Response and click Submit\n6. Transaction is successful',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  cart.removeAll();
                  Navigator.of(context).pushReplacementNamed('/payment_success');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: const Color(0xFFD4A056),
                ),
                child: const Text(
                  'Verify Payment Status',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
