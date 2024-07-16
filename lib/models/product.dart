class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  final double rating;
  int quantity; 

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rating,
    this.quantity = 1, 
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null ? json['rating']['rate'].toDouble() : 0.0,
    );
  }
}
