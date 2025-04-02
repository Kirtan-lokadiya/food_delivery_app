import 'cart_item.dart';

class Cart {
  final String? restaurantId;
  final List<CartItem> items;

  Cart({
    this.restaurantId,
    required this.items,
  });

  double get totalAmount {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurantId': restaurantId,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
} 