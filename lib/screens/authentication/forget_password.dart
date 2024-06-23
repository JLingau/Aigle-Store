import 'package:aigle/utils/auth.dart';
import 'package:aigle/utils/toast.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void submitHandler() async {
    if (formKey.currentState!.validate()) {
      var response = await Auth.resetPassword(context, emailController.text);
      if (response == true) {
        if (context.mounted) {
          Toast.alert(context, "Password Reset Succesful !", AlertType.success);
          Navigator.of(context).pushReplacementNamed("/login");
        }
      } else {
        if (context.mounted) {
          Toast.alert(context, "Invalid Email !", AlertType.error);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFD4A056),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 24, right: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Enter your email",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email is required";
                                  } else if (!value.contains("@")) {
                                    return "Input valid email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ), // Spasi tambahan
                        ElevatedButton(
                          onPressed: loading
                              ? () {}
                              : () {
                                  submitHandler();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: loading
                                ? Colors.grey
                                : const Color(0xFFD4A056),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                            ),
                          ),
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            child: Text(
                              loading ? "Loading" : "Reset Password",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
