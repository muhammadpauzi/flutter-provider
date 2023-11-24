import 'dart:convert';

import 'package:flutter_tutorials/config.dart';
import 'package:flutter_tutorials/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> getAll(int? page) async {
    int skip = (page is int && page > 0) ? (page * 10) : 0;

    List<Product> products = [];
    try {
      Uri uri = Uri.parse(BASE_URL).replace(
        path: '/products',
        queryParameters: {
          'skip': skip.toString(),
          'limit': '10',
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        for (var product in data['products']) {
          products.add(Product.fromJson(product));
        }
      }

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product?> find(int id) async {
    try {
      Uri uri = Uri.parse(BASE_URL).replace(
        path: '/products/$id',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return Product.fromJson(data);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }
}
