import 'package:flutter/material.dart';

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
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Image.network(
                          "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Product 1",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "\$ 200",
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
                        // Implement removal logic here
                      },
                    ),
                  );
                }),
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
