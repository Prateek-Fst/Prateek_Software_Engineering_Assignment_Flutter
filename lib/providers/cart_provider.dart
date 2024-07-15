import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    _cartItems.forEach((product) {
      total += product.price;
    });
    return total;
  }
}
