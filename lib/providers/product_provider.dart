import 'package:flutter/material.dart';
import 'package:flutter_tutorials/models/product.dart';
import 'package:flutter_tutorials/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  bool isLoading = false;
  bool isScrollFetch = false;
  List<Product> products = [];

  Future<void> getAllProducts({
    int? page,
    bool usingScrollFetch = false,
  }) async {
    isScrollFetch = usingScrollFetch;
    isLoading = true;
    notifyListeners();
    // await Future.delayed(const Duration(seconds: 5));

    await _fetchProducts(page: page, usingScrollFetch: usingScrollFetch);

    isScrollFetch = false;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllProductsWithoutLoading() async {
    await _fetchProducts();
    notifyListeners();
  }

  Future<void> _fetchProducts({
    int? page = 0,
    bool usingScrollFetch = false,
  }) async {
    final fetchedProducts = await _service.getAll(page);
    usingScrollFetch
        ? products.addAll(fetchedProducts)
        : products = fetchedProducts;
  }
}
