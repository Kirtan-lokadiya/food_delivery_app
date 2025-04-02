class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String cuisineType;
  final String deliveryTime;
  final String address;
  final bool isOpen;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.cuisineType,
    required this.deliveryTime,
    required this.address,
    this.isOpen = true,
  });

  Restaurant copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? rating,
    String? cuisineType,
    String? deliveryTime,
    String? address,
    bool? isOpen,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      cuisineType: cuisineType ?? this.cuisineType,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      address: address ?? this.address,
      isOpen: isOpen ?? this.isOpen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'rating': rating,
      'cuisineType': cuisineType,
      'deliveryTime': deliveryTime,
      'address': address,
      'isOpen': isOpen,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? 'https://via.placeholder.com/150',
      rating: (map['rating'] ?? 0.0).toDouble(),
      cuisineType: map['cuisineType'] ?? '',
      deliveryTime: map['deliveryTime'] ?? '',
      address: map['address'] ?? '',
      isOpen: map['isOpen'] ?? true,
    );
  }
}
