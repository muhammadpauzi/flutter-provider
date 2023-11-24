class Product {
  int id;
  String title;
  String? description;
  int price;
  String thumbnail;

  Product({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        thumbnail: json['thumbnail'],
      );
}
