import 'package:flutter/material.dart';
import 'package:flutter_tutorials/models/product.dart';
import 'package:flutter_tutorials/pages/cart_page.dart';
import 'package:flutter_tutorials/providers/cart_provider.dart';
import 'package:flutter_tutorials/providers/product_provider.dart';
import 'package:flutter_tutorials/services/product_service.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _scrollController = ScrollController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _currentPage++;

        try {
          Provider.of<ProductProvider>(context, listen: false).getAllProducts(
            page: _currentPage,
            usingScrollFetch: true,
          );
        } catch (e) {
          // if error, reset to last current page
          _currentPage--;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int countOfCart = context.watch<CartProvider>().cartOfProducts.length;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Stack(
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 28,
                  ),
                  if (countOfCart > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 15,
                          minHeight: 10,
                        ),
                        child: Text(
                          countOfCart.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Consumer<ProductProvider>(
            builder: (context, value, child) {
              if (!value.isScrollFetch && value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<ProductProvider>(context, listen: false)
                      .getAllProductsWithoutLoading();
                },
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 8.0, // Spacing between rows
                  ),
                  itemCount: value.products.length,
                  itemBuilder: (context, index) {
                    final product = value.products[index];

                    return ProductCard(product: product);
                  },
                ),
              );
            },
          ),
        ));
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            showDragHandle: true,
            context: context,
            // TODO: Remove when this is in the framework https://github.com/flutter/flutter/issues/118619
            constraints: const BoxConstraints(maxWidth: 640),
            builder: (context) {
              return SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () async {
                                bool status = await Provider.of<CartProvider>(
                                  context,
                                  listen: false,
                                ).addProductToCart(
                                  product.id.toInt(),
                                );

                                if (context.mounted) {
                                  Navigator.of(context).pop();

                                  // Find the nearest Scaffold in the widget tree
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Product successfully added to cart!'),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              },
                              icon: const Icon(
                                Icons.add_shopping_cart,
                              ),
                            ),
                            const Text("Add to cart"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image.network(
                product.thumbnail,
                width: double.infinity,
                height: 130.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    '\$${product.price}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black.withOpacity(.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
