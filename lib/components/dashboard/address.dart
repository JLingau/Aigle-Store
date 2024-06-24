import 'package:aigle/utils/profile_detail.dart';
import 'package:aigle/utils/toast.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final ProfileDetail _profileDetail = ProfileDetail();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileDetail.getProfileData().then((value) {
      setState(() {
        addressController = TextEditingController(text: value['address']);
        numberController = TextEditingController(text: value['phoneNumber'].toString());
      });
    });
  }

  @override
  void dispose() {
    addressController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Set Address & Number',
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change your address : ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: addressController,
              minLines: 4,
              maxLines: 6,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Address is required !";
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(height: 20),
            const Text(
              'Change your phone number : ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: numberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Phone number is required!";
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      try {
                        _profileDetail.setAddressAndNumber(
                            addressController.text,
                            int.parse(numberController.text));
                      } catch (e) {
                        Toast.alert(
                          context,
                          'Failed to update profile',
                          AlertType.error,
                        );
                      }
                      Toast.alert(
                          context,
                          'Succesfully update profile',
                          AlertType.success,
                        );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color(0xFFD4A056),
                  ),
                  child: const Text(
                    'Confirm set data',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
