import 'package:aigle/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:aigle/utils/profile_detail.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? userStatus = FirebaseAuth.instance.currentUser;
  final ProfileDetail _profileDetail = ProfileDetail();
  String name = '';

  @override
  void initState() {
    super.initState();
    if (userStatus != null) {
      _profileDetail.getName().then((String value) {
        setState(() {
          name = value;
        });
      });
    }
  }

  void logout(
    BuildContext context,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      if (context.mounted) {
        Toast.alert(
          context,
          "Logged Out Successfully",
          AlertType.success,
        );
        Navigator.of(context).pushReplacementNamed("/dashboard");
      }
    } catch (e) {
      if (context.mounted) {
        Toast.alert(
          context,
          e.toString(),
          AlertType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(51, 60, 72, 1),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 125),
              Expanded(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    padding: const EdgeInsets.all(5),
                    child: userStatus != null
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                name.isNotEmpty
                                    ? name.toUpperCase()
                                    : 'Loading...',
                                style: const TextStyle(
                                    color: Color(0xff333C48),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/profile_data');
                                },
                                child: const ListTile(
                                  leading: Icon(
                                    Icons.home_filled,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    'Edit Address and Phone Number',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  logout(context);
                                },
                                child: const ListTile(
                                  leading: Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/login');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff333C48),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account yet?',
                                    style: TextStyle(
                                      color: Color(0xFF757575),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/register');
                                      },
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Color(0xFFD4A056),
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/faq");
                                },
                                child: const ListTile(
                                  leading: Icon(
                                    Icons.question_mark_rounded,
                                    color: Color(0xFF757575),
                                  ),
                                  title: Text(
                                    'FAQ',
                                    style: TextStyle(
                                      color: Color(0xFF757575),
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xFF757575),
                                    size: 25,
                                  ),
                                ),
                              )
                            ],
                          )),
              )
            ],
          ),
          Positioned(
              top: 83.5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: userStatus != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(240),
                        child: const Image(
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.cover,
                          height: 75,
                          width: 75,
                        ),
                      )
                    : Container(
                        height: 75,
                        width: 75,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFD4A056)),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
              ))
        ],
      ),
    );
  }
}
