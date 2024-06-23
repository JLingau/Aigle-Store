import 'package:aigle/utils/auth.dart';
import 'package:aigle/utils/toast.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  bool loading = false;
  bool obscurePassword = true;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void submitHandler() async {
      if (formKey.currentState!.validate()) {
        try {
          setState(() {
            loading = true;
          });
          await Auth.login(
            context,
            emailController.text,
            passwordController.text,
          );
          if (context.mounted) {
            Toast.alert(
              context,
              "Logged In Successfully",
              AlertType.success,
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/dashboard",
              (route) => false,
            );
          }
          setState(() {
            loading = false;
          });
        } catch (e) {
          if (context.mounted) {
            Toast.alert(
              context,
              "Invalid email or password",
              AlertType.error,
            );
          }
          setState(() {
            loading = false;
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 15.0),
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Welcome Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black),
            ),
            const Text(
              "Order Glasses According To Your Wishes",
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Input your email",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required !";
                      } else if (!value.contains("@")) {
                        return "Input valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword ? true : false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: "Input your password",
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 2, minHeight: 2),
                        suffixIcon: InkWell(
                          child: const Icon(Icons.remove_red_eye_outlined),
                          onTap: () {
                            setState(() {
                              if (obscurePassword) {
                                obscurePassword = false;
                              } else {
                                obscurePassword = true;
                              }
                              ;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required !";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                            activeColor: Colors.amber,
                          ),
                          const Text("Remember me",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14.0))
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/forget_password');
                          },
                          child: const Text("Reset Password?",
                              style: TextStyle(
                                  color: Colors.amber, fontSize: 15.0))),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: loading ? () {} : submitHandler,
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isChecked && !loading ? Colors.amber : Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        loading ? "Loading..." : "Login",
                        style: TextStyle(
                            color: isChecked ? Colors.white : Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Text(
                          "or",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await Auth.googleLogin(context);
                        if (context.mounted) {
                          Toast.alert(
                            context,
                            "Logged In Successfully",
                            AlertType.success,
                          );
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/dashboard',
                            (route) => false,
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Toast.alert(
                            context,
                            "Unable to Login",
                            AlertType.error,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google_logo.png',
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            "Continue With Google",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Don't have an account yet?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/register");
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
