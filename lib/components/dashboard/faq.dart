import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  const Faq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ (Frequently Asked Question)'),
        toolbarHeight: 70,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: faqItems.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(faqItems[index]["question"]!),
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  top: 0,
                  left: 16,
                  right: 16,
                ),
                child: Text(faqItems[index]["answer"]!, textAlign: TextAlign.justify,),
              ),
            ],
          );
        },
      ),
    );
  }
}

List<Map<String, String>> faqItems = [
  {
    "question": "Apa itu Aigle ?",
    "answer": "Aigle merupakan aplikasi mobile online eyewear shopping termudah dan terlengkap. pesan kacamata favorit anda darimana saja dan biarkan kami menghandle pengiriman dan packagingnya."
  },
  {
    "question": "Bagaimana cara memesan kacamata?",
    "answer": "Anda perlu mendaftar akun terlebih dahulu untuk melengkapi data pribadi anda yang tentunya kami lindungi kerahasiaannya, kemudian anda dapat memesan dari halaman products."
  },
  {
    "question": "Apa saja ketentuan mendaftar di aplikasi Aigle?",
    "answer": "Anda hanya perlu memiliki email saja, maka pendaftaran aigle dapat dilakukan dengan mudah."
  },
  {
    "question": "Apa yang harus dilakukan ketika lupa password atau ingin mengubah password?",
    "answer": "Anda dapat menekan 'Forgot Password ?' pada halaman login. Setelah masuk ke halaman Reset Password, masukkan email anda dan tekan 'Reset Password'. Kemudian link akan dikirim di email anda untuk melakukan rest password."
  }
];