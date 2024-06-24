import 'package:aigle/models/product_cart.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductCart> _items = [];
  List<ProductCart> get items => _items;

  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in items) {
      totalPrice += item.price * item.quantity;
    }

    return totalPrice;
  }

  void addItem(ProductCart item) {
    final itemIndex = _items.indexWhere((element) => element.id == item.id && element.customization == item.customization);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity++;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeQuantity(ProductCart item) {
    final itemIndex = _items.indexWhere((element) => element.id == item.id && element.customization == item.customization);
    if (_items[itemIndex].quantity > 1) {
      _items[itemIndex].quantity--;
    } else {
      _items.removeAt(itemIndex);
    }
    notifyListeners();
  }

  void removeItem(ProductCart item) {
    final itemIndex = _items.indexWhere((element) => element.id == item.id && element.customization == item.customization);
    _items.removeAt(itemIndex);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  int getCounter() {
    return items.length;
  }
}
