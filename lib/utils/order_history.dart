import 'package:aigle/models/order_model.dart';
import 'package:aigle/models/product_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderHistory {
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Orders');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> setOrderHistory(
      BuildContext context, List<ProductCart> carts) async {
    // Turning instance of object to map
    List<Map<String, dynamic>> product = [];
    for (final cart in carts) {
      product.add(cart.toMap());
    }

    await orderCollection
        .doc(((await getAllProductsCount())! + 1).toString())
        .set({
      'id': (await getAllProductsCount())! + 1,
      'userId': auth.currentUser!.uid,
      'status': 'completed',
      'orderItem': product
    });
  }

  Stream<List<OrderModel>> getAllProducts() {
    return orderCollection
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    });
  }

  Future<int?> getAllProductsCount() async {
    return await orderCollection.count().get().then((value) {
      return value.count;
    });
  }
}
