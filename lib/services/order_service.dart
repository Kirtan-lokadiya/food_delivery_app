import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order.dart';
import '../models/cart.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new order
  Future<Order> createOrder({
    required String userId,
    required String restaurantId,
    required Cart cart,
    required String deliveryAddress,
    required double deliveryFee,
  }) async {
    try {
      final orderRef = _firestore.collection('orders').doc();
      final order = Order(
        id: orderRef.id,
        userId: userId,
        restaurantId: restaurantId,
        items: cart.items,
        totalAmount: cart.totalAmount + deliveryFee,
        status: OrderStatus.pending,
        orderTime: DateTime.now(),
        deliveryAddress: deliveryAddress,
        deliveryFee: deliveryFee,
      );

      await orderRef.set(order.toJson());

      // Update user's order history
      await _firestore.collection('users').doc(userId).update({
        'orderHistory': FieldValue.arrayUnion([orderRef.id])
      });

      return order;
    } catch (e) {
      rethrow;
    }
  }

  // Get user's orders
  Stream<List<Order>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('orderTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Order.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // Get order by ID
  Future<Order?> getOrderById(String orderId) async {
    try {
      final doc = await _firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return Order.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': status.toString(),
        if (status == OrderStatus.delivered)
          'deliveryTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Cancel order
  Future<void> cancelOrder(String orderId) async {
    try {
      await updateOrderStatus(orderId, OrderStatus.cancelled);
    } catch (e) {
      rethrow;
    }
  }

  // Get active orders for a restaurant
  Stream<List<Order>> getRestaurantActiveOrders(String restaurantId) {
    return _firestore
        .collection('orders')
        .where('restaurantId', isEqualTo: restaurantId)
        .where('status', whereIn: [
          OrderStatus.pending.toString(),
          OrderStatus.confirmed.toString(),
          OrderStatus.preparing.toString(),
          OrderStatus.ready.toString(),
        ])
        .orderBy('orderTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Order.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // Get delivery orders for a driver
  Stream<List<Order>> getDriverOrders(String driverId) {
    return _firestore
        .collection('orders')
        .where('driverId', isEqualTo: driverId)
        .where('status', whereIn: [
          OrderStatus.ready.toString(),
          OrderStatus.onTheWay.toString(),
        ])
        .orderBy('orderTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Order.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // Assign driver to order
  Future<void> assignDriver(String orderId, String driverId) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'driverId': driverId,
        'status': OrderStatus.onTheWay.toString(),
      });
    } catch (e) {
      rethrow;
    }
  }
} 