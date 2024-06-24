import 'package:aigle/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('Products');

  Stream<List<ProductModel>> getAllProducts() {
    return _productsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<int?> getAllProductsCount() async {
    return await _productsCollection.count().get().then((value) {
      return value.count;
    });
  }

  Future<int?> getCategorizedProductsCount(String category) async {
    return await _productsCollection
        .where("category", isEqualTo: category.toLowerCase())
        .count()
        .get()
        .then((value) {
      return value.count;
    });
  }
}
