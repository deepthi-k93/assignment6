import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:vendor_application/features/cart/model/cart_product_model.dart';

class CartProvider with ChangeNotifier {
  var logger = Logger();

  final List<CartProductModel> _cartItems = [];
  List<CartProductModel> get cartItems => [..._cartItems];
  int get cartCount => _cartItems.length;
  //int count = cartItems.

  CartProductModel? productDetails;
  void setProductDetails(CartProductModel product) {
    productDetails = product;
    notifyListeners();
  }

  void addToCartItems(CartProductModel product) {
    logger.i("hi add");
    if (isInCart(product.id.toString())) {
      //increment the count
    } else {
      logger.i("added");
      _cartItems.add(product);
      logger.i("added {${product.count}}");
    }
    notifyListeners();
  }

  bool isInCart(String string) {
    return false;
  }

  int calculateSubTotal(CartProductModel product) {
    return (product.count! * product.price!);
  }

  double calculateTotal() {
    double total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      total = total + (cartItems[i].count! * cartItems[i].price!);
    }
    return (total);
  }

  int countProducts() {
    int totCount = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totCount = totCount + cartItems[i].count!;
    }
    return totCount;
  }

  double calculateDiscount(int discount) {
    var tot = calculateTotal();
    var discounted = tot * (100 - discount) / 100;
    return discounted;
  }
}
