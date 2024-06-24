import 'package:aigle/utils/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static Future<void> checkAuthStatus(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.authStateChanges().first;
    if (auth.currentUser != null && context.mounted) {
      Navigator.of(context).pushReplacementNamed("/dashboard");
    }
  }

  static Future<UserCredential> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> register(
    BuildContext context,
    String email,
    String password,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<bool> resetPassword(
    BuildContext context,
    String email,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> insertProfile(
    BuildContext context,
    String username,
    String email
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      await db.collection('Users').doc(auth.currentUser?.uid).set({
        'name' : username,
        'email' : email,
        'address' : null,
        'phoneNumber': null
      });
    }
  }

  static void updateProfile(
    BuildContext context,
    String fullName,
    String phoneNumber,
    String gender,
    String birthDate,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      try {
        await db.collection("users").doc(auth.currentUser!.uid).set(
          {
            fullName: fullName,
            phoneNumber: phoneNumber,
            gender: gender,
            birthDate: birthDate,
          },
        );
      } catch (e) {
        if (context.mounted) {
          Toast.alert(
            context,
            "Couldn't Update Profile",
            AlertType.error,
          );
        }
      }
    }
  }

  static Future<UserCredential> googleLogin(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
