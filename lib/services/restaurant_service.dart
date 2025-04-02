import 'package:flutter/foundation.dart';
import '../models/restaurant.dart';
import '../models/menu_item.dart';

class RestaurantService {
  // Mock restaurant data
  final List<Restaurant> _restaurants = [
    Restaurant(
      id: 'r1',
      name: 'Delicious Bistro',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      rating: 4.7,
      cuisineType: 'Italian',
      deliveryTime: '25-35 min',
      address: '123 Main St, Anytown, USA',
      isOpen: true,
    ),
    Restaurant(
      id: 'r2',
      name: 'Spice Paradise',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      rating: 4.5,
      cuisineType: 'Indian',
      deliveryTime: '30-45 min',
      address: '456 Oak Ave, Anytown, USA',
      isOpen: true,
    ),
    Restaurant(
      id: 'r3',
      name: 'Sushi Express',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      rating: 4.8,
      cuisineType: 'Japanese',
      deliveryTime: '20-30 min',
      address: '789 Pine Rd, Anytown, USA',
      isOpen: true,
    ),
    Restaurant(
      id: 'r4',
      name: 'Burger Joint',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      rating: 4.3,
      cuisineType: 'American',
      deliveryTime: '15-25 min',
      address: '101 Maple Dr, Anytown, USA',
      isOpen: true,
    ),
    Restaurant(
      id: 'r5',
      name: 'Taco Heaven',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      rating: 4.4,
      cuisineType: 'Mexican',
      deliveryTime: '20-35 min',
      address: '202 Elm St, Anytown, USA',
      isOpen: false,
    ),
  ];

  // Mock menu items data
  final Map<String, List<MenuItem>> _menuItems = {
    'r1': [
      MenuItem(
        id: 'm1',
        name: 'Margherita Pizza',
        description: 'Classic pizza with tomato sauce, mozzarella, and basil',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Pizza',
      ),
      MenuItem(
        id: 'm2',
        name: 'Fettuccine Alfredo',
        description: 'Creamy pasta with parmesan cheese sauce',
        price: 14.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Pasta',
      ),
      MenuItem(
        id: 'm3',
        name: 'Tiramisu',
        description: 'Italian coffee-flavored dessert',
        price: 7.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Dessert',
      ),
      MenuItem(
        id: 'm4',
        name: 'Caprese Salad',
        description: 'Fresh tomatoes, mozzarella, and basil with balsamic glaze',
        price: 8.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Salad',
      ),
    ],
    'r2': [
      MenuItem(
        id: 'm5',
        name: 'Butter Chicken',
        description: 'Tender chicken in a rich tomato and butter sauce',
        price: 15.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Main Courses',
      ),
      MenuItem(
        id: 'm6',
        name: 'Vegetable Samosas',
        description: 'Crispy pastry filled with spiced potatoes and peas',
        price: 6.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Appetizers',
      ),
      MenuItem(
        id: 'm7',
        name: 'Garlic Naan',
        description: 'Flatbread with garlic and butter',
        price: 3.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Bread',
      ),
    ],
    'r3': [
      MenuItem(
        id: 'm8',
        name: 'Salmon Nigiri',
        description: 'Fresh salmon on seasoned rice',
        price: 5.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Nigiri',
      ),
      MenuItem(
        id: 'm9',
        name: 'California Roll',
        description: 'Crab, avocado, and cucumber roll',
        price: 7.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Maki',
      ),
      MenuItem(
        id: 'm10',
        name: 'Miso Soup',
        description: 'Traditional Japanese soup with tofu and seaweed',
        price: 3.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Soup',
      ),
    ],
    'r4': [
      MenuItem(
        id: 'm11',
        name: 'Classic Cheeseburger',
        description: 'Beef patty with cheese, lettuce, tomato, and special sauce',
        price: 9.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Burgers',
      ),
      MenuItem(
        id: 'm12',
        name: 'Loaded Fries',
        description: 'Crispy fries topped with cheese, bacon, and sour cream',
        price: 6.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Sides',
      ),
      MenuItem(
        id: 'm13',
        name: 'Chocolate Milkshake',
        description: 'Rich and creamy chocolate shake',
        price: 4.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Drinks',
      ),
    ],
    'r5': [
      MenuItem(
        id: 'm14',
        name: 'Beef Tacos',
        description: 'Three soft corn tortillas with seasoned beef, onions, and cilantro',
        price: 8.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Tacos',
      ),
      MenuItem(
        id: 'm15',
        name: 'Chicken Quesadilla',
        description: 'Grilled tortilla filled with chicken and cheese',
        price: 10.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Quesadillas',
      ),
      MenuItem(
        id: 'm16',
        name: 'Guacamole & Chips',
        description: 'Fresh avocado dip with crispy tortilla chips',
        price: 5.99,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
        category: 'Sides',
      ),
    ],
  };

  // Get all restaurants with optional filter
  Future<List<Restaurant>> getRestaurants() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _restaurants;
  }

  // Get restaurants by cuisine type
  Future<List<Restaurant>> getRestaurantsByCuisine(String cuisineType) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    return _restaurants
        .where((restaurant) => restaurant.cuisineType.toLowerCase() == cuisineType.toLowerCase())
        .toList();
  }

  // Get a restaurant by ID
  Future<Restaurant?> getRestaurantById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _restaurants.firstWhere((restaurant) => restaurant.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get menu items for a restaurant
  Future<List<MenuItem>> getMenuItems(String restaurantId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _menuItems[restaurantId] ?? [];
  }

  // Get menu items by category
  Future<List<MenuItem>> getMenuItemsByCategory(String restaurantId, String category) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    final items = _menuItems[restaurantId] ?? [];
    return items.where((item) => item.category == category).toList();
  }

  // Get available menu categories for a restaurant
  Future<List<String>> getMenuCategories(String restaurantId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    final items = _menuItems[restaurantId] ?? [];
    final categories = items.map((item) => item.category).toSet().toList();
    return categories;
  }
} 