import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileDetail {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot> getProfileName() {
    final docRef = userCollection.doc(auth.currentUser!.uid);
    return docRef.snapshots();
  }

  Future<String> getName() async {
    final docRef = userCollection.doc(auth.currentUser?.uid);
    return await docRef.get().then((value) {
      return value['name'];
    });
  }

  Future<DocumentSnapshot<Object?>> getProfileData() async {
    final docRef = userCollection.doc(auth.currentUser?.uid);
    return await docRef.get();
  }

  Future<void> setAddressAndNumber(String address, int number) async {
    final docRef = userCollection.doc(auth.currentUser?.uid);
    await docRef.update({'address': address, 'phoneNumber': number});
  }
}
