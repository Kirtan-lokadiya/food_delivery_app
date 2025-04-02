class FoodItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String restaurantId;
  final String category;
  
  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.restaurantId,
    required this.category,
  });
  
  factory FoodItem.fromMap(Map<String, dynamic> map, String id) {
    return FoodItem(
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      restaurantId: map['restaurantId'] ?? '',
      category: map['category'] ?? '',
    );
  }
}
