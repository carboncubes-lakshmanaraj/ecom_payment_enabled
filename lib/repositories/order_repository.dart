import 'package:ecom_payment/dbmanager/db.dart';
import 'package:ecom_payment/datas/cartitem.dart';

class OrderRepository {
  /// Create a new order with cart items
  static Future<int> createOrder({
    required String email,
    required List<CartItem> cartItems,
  }) async {
    final db = await DBManager.database;

    double total = cartItems.fold(
      0,
      (sum, item) => sum + item.product.discountedPrice * 1,
    );

    // Insert into Orders table
    int orderId = await db.insert("Orders", {
      'Email': email,
      'TotalPrice': total,
      'OrderStatus': 'Pending',
      'PaymentIntentID': null, // initialize as null
    });

    // Insert order items
    for (var item in cartItems) {
      await db.insert("OrderItems", {
        'OrderID': orderId,
        'ProductTitle': item.product.title,
        'ProductImage': item.product.productImage,
        'SelectedSize': item.selectedSize,
        'Quantity': 1,
        'Price': item.product.discountedPrice,
      });
    }

    return orderId;
  }

  /// Fetch order and items by orderId
  static Future<Map<String, dynamic>> getOrderWithItems(int orderId) async {
    final db = await DBManager.database;

    final order = await db.query(
      'Orders',
      where: 'OrderID = ?',
      whereArgs: [orderId],
    );

    final items = await db.query(
      'OrderItems',
      where: 'OrderID = ?',
      whereArgs: [orderId],
    );

    if (order.isEmpty) {
      throw Exception("Order not found for ID $orderId");
    }

    return {'order': order.first, 'items': items};
  }

  /// Update the payment/order status
  static Future<void> updateOrderStatus(int orderId, String status) async {
    final db = await DBManager.database;

    await db.update(
      'Orders',
      {'OrderStatus': status},
      where: 'OrderID = ?',
      whereArgs: [orderId],
    );
  }

  /// Save Stripe PaymentIntent ID (used for idempotency)
  static Future<void> savePaymentIntentId(int orderId, String intentId) async {
    final db = await DBManager.database;

    await db.update(
      'Orders',
      {'PaymentIntentID': intentId},
      where: 'OrderID = ?',
      whereArgs: [orderId],
    );
  }

  /// Retrieve saved Stripe PaymentIntent ID (if any)
  static Future<String?> getPaymentIntentId(int orderId) async {
    final db = await DBManager.database;

    final result = await db.query(
      'Orders',
      columns: ['PaymentIntentID'],
      where: 'OrderID = ?',
      whereArgs: [orderId],
    );

    if (result.isNotEmpty && result.first['PaymentIntentID'] != null) {
      return result.first['PaymentIntentID'] as String;
    }

    return null;
  }

  /// Optional: Fetch all orders by status
  static Future<List<Map<String, dynamic>>> getOrdersByStatus(
    String status,
  ) async {
    final db = await DBManager.database;
    return await db.query(
      'Orders',
      where: 'OrderStatus = ?',
      whereArgs: [status],
      orderBy: 'OrderDate DESC',
    );
  }
}
