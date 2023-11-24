import 'package:flutter/material.dart';
import 'package:flutter_tutorials/models/product.dart';
import 'package:flutter_tutorials/services/product_service.dart';

class CartProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> cartOfProducts = [];

  Future<bool> addProductToCart(int idProduct) async {
    Product? product = await _service.find(idProduct);
    if (product == null) {
      return false;
    }

    cartOfProducts.add(product);
    notifyListeners();

    return true;
  }

  void removeProductInCart(int idProduct) async {
    cartOfProducts.removeWhere((product) => product.id == idProduct);
    notifyListeners();
  }
}
