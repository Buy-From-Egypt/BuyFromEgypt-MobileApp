class Product {
  final String image;
  final String brand;
  final String name;
  final double price;
  final String? description; // Make it nullable

  Product({
    required this.image,
    required this.brand,
    required this.name,
    required this.price,
    this.description, // No 'required' here
  });
}
