import 'menu_item.dart';

class CartItem {
  final MenuItem item;
  final int quantity;

  CartItem({
    required this.item,
    this.quantity = 1,
  });

  double get totalPrice => item.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'itemId': item.id,
      'name': item.name,
      'price': item.price,
      'quantity': quantity,
      'imageUrl': item.imageUrl,
    };
  }

  CartItem copyWith({
    MenuItem? item,
    int? quantity,
  }) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }
}
