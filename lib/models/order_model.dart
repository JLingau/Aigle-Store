import 'package:aigle/models/product_cart.dart';

class OrderModel {
  final int id;
  final int userId;
  final String status;
  final List<ProductCart> orderItem;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.orderItem
  });

  factory OrderModel.fromSnapshot(doc) {
    return OrderModel(
      id: doc['id'],
      userId: doc['userId'],
      status: doc['status'],
      orderItem: doc['orderItem']
    );
  }
}