import 'package:flutter/material.dart';
import 'package:flutter_tutorials/models/product.dart';
import 'package:flutter_tutorials/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                    itemCount: value.cartOfProducts.length,
                    itemBuilder: (context, index) {
                      Product product = value.cartOfProducts[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Image.network(
                              product.thumbnail,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "\$${product.price}",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black.withOpacity(.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        trailing: IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.remove_shopping_cart_outlined),
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .removeProductInCart(product.id);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'Product successfully remove from cart!'),
                              duration: Duration(seconds: 3),
                            ));
                          },
                        ),
                      );
                    });
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_circle_right_outlined),
              label: const Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }
}
