class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final List<String> favoriteRestaurants;
  final List<String> orderHistory;
  final bool isDarkMode;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.favoriteRestaurants,
    required this.orderHistory,
    required this.isDarkMode,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      favoriteRestaurants: List<String>.from(json['favoriteRestaurants'] ?? []),
      orderHistory: List<String>.from(json['orderHistory'] ?? []),
      isDarkMode: json['isDarkMode'] ?? false,
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'favoriteRestaurants': favoriteRestaurants,
      'orderHistory': orderHistory,
      'isDarkMode': isDarkMode,
      'profileImage': profileImage,
    };
  }

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? profileImage,
    List<String>? favoriteRestaurants,
    List<String>? orderHistory,
    bool? isDarkMode,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      favoriteRestaurants: favoriteRestaurants ?? this.favoriteRestaurants,
      orderHistory: orderHistory ?? this.orderHistory,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      profileImage: profileImage ?? this.profileImage,
    );
  }
} 