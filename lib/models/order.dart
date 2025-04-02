import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_item.dart';
import 'menu_item.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  onTheWay,
  delivered,
  cancelled
}

class Order {
  final String id;
  final String userId;
  final String restaurantId;
  final List<CartItem> items;
  final double totalAmount;
  final OrderStatus status;
  final DateTime orderTime;
  final DateTime? deliveryTime;
  final String deliveryAddress;
  final double deliveryFee;
  final String? driverId;
  final String? deliveryInstructions;

  Order({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.orderTime,
    this.deliveryTime,
    required this.deliveryAddress,
    required this.deliveryFee,
    this.driverId,
    this.deliveryInstructions,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      items: (json['items'] as List)
          .map((item) => CartItem(
                item: MenuItem.fromJson(item['item']),
                quantity: item['quantity'],
              ))
          .toList(),
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      orderTime: (json['orderTime'] as Timestamp).toDate(),
      deliveryTime: json['deliveryTime'] != null
          ? (json['deliveryTime'] as Timestamp).toDate()
          : null,
      deliveryAddress: json['deliveryAddress'] ?? '',
      deliveryFee: (json['deliveryFee'] ?? 0.0).toDouble(),
      driverId: json['driverId'],
      deliveryInstructions: json['deliveryInstructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'items': items
          .map((item) => {
                'item': item.item.toJson(),
                'quantity': item.quantity,
              })
          .toList(),
      'totalAmount': totalAmount,
      'status': status.toString(),
      'orderTime': Timestamp.fromDate(orderTime),
      'deliveryTime':
          deliveryTime != null ? Timestamp.fromDate(deliveryTime!) : null,
      'deliveryAddress': deliveryAddress,
      'deliveryFee': deliveryFee,
      'driverId': driverId,
      'deliveryInstructions': deliveryInstructions,
    };
  }

  static Map<String, dynamic> cartItemToMap(CartItem item) {
    return {
      'id': item.item.id,
      'name': item.item.name,
      'price': item.item.price,
      'quantity': item.quantity,
    };
  }
}
