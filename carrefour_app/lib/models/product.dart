class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final String image;
  final bool isPromotion;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.image,
    this.isPromotion = false,
    required this.description,
  });
}
