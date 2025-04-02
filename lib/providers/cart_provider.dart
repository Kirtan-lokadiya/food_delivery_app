import 'package:flutter/foundation.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/menu_item.dart';

class CartProvider with ChangeNotifier {
  Cart? _cart;

  Cart? get cart => _cart;
  
  String? get restaurantId => _cart?.restaurantId;
  
  bool get isEmpty => _cart == null || _cart!.items.isEmpty;
  
  double get totalAmount => _cart?.totalAmount ?? 0;

  bool canAddItem(String newRestaurantId) {
    if (_cart == null || _cart!.items.isEmpty) {
      return true;
    }
    return restaurantId == newRestaurantId;
  }

  void addItem(MenuItem item, String restaurantId) {
    if (_cart == null) {
      _cart = Cart(
        restaurantId: restaurantId,
        items: [CartItem(item: item)],
      );
      notifyListeners();
      return;
    }

    // Check if the item is from a different restaurant
    if (_cart!.restaurantId != restaurantId) {
      throw Exception('Cannot add items from different restaurants');
    }

    // Check if the item is already in the cart
    final existingIndex = _cart!.items.indexWhere((cartItem) => cartItem.item.id == item.id);
    
    if (existingIndex >= 0) {
      // Update existing item quantity
      final existingItem = _cart!.items[existingIndex];
      final updatedItems = List<CartItem>.from(_cart!.items);
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
      
      _cart = Cart(
        restaurantId: restaurantId,
        items: updatedItems,
      );
    } else {
      // Add new item
      _cart = Cart(
        restaurantId: restaurantId,
        items: [..._cart!.items, CartItem(item: item)],
      );
    }
    
    notifyListeners();
  }

  void removeItem(String itemId) {
    if (_cart == null) return;
    
    final updatedItems = _cart!.items.where((item) => item.item.id != itemId).toList();
    
    if (updatedItems.isEmpty) {
      _cart = null;
    } else {
      _cart = Cart(
        restaurantId: _cart!.restaurantId,
        items: updatedItems,
      );
    }
    
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    if (_cart == null) return;
    
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }
    
    final itemIndex = _cart!.items.indexWhere((item) => item.item.id == itemId);
    
    if (itemIndex == -1) return;
    
    final updatedItems = List<CartItem>.from(_cart!.items);
    updatedItems[itemIndex] = _cart!.items[itemIndex].copyWith(quantity: quantity);
    
    _cart = Cart(
      restaurantId: _cart!.restaurantId,
      items: updatedItems,
    );
    
    notifyListeners();
  }

  void clearCart() {
    _cart = null;
    notifyListeners();
  }
} 