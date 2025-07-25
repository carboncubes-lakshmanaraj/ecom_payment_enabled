import 'package:ecom_payment/dbmanager/db.dart';
import 'package:ecom_payment/datas/cartitem.dart';
import 'package:ecom_payment/screens/cartpage.dart';
import 'package:uuid/uuid.dart';
class OrderRepository {
  /// Create a new order with cart items
  static Future<int> createOrder({
    required String selectedcurrency,
    required String email,
    required List<CartItem> cartItems,
  }) async {
    final db = await DBManager.database;

    double total = 0.0;

    for (var item in cartItems) {
      final discountedPrice = getDiscountedPrice(
        item.product,
        selectedcurrency,
      );
      total += discountedPrice;
    }

    // Insert into Orders table
    int orderId = await db.insert("Orders", {
      'CurrencyID': selectedcurrency,
      'Email': email,
      'TotalPrice': total,
      'OrderStatus': 'Pending',
      'PaymentIntentID': null,
    });

    for (var item in cartItems) {
      final discountedPrice = getDiscountedPrice(
        item.product,
        selectedcurrency,
      );

      await db.insert("OrderItems", {
        'OrderID': orderId,
        'ProductTitle': item.product.title,
        'ProductImage': item.product.productImage,
        'SelectedSize': item.selectedSize,

        'Price': discountedPrice,
      });
    }

    return orderId;
  }


/// Generate and save a new idempotency key for this order
static Future<String> generateAndSaveIdempotencyKey(int orderId) async {
  final db = await DBManager.database;

  final uuid = Uuid();
  final newKey = "ord-$orderId-${uuid.v4()}";

  await db.update(
    'Orders',
    {'IdempotencyKey': newKey},
    where: 'OrderID = ?',
    whereArgs: [orderId],
  );

  return newKey;
}



/// Retrieve existing idempotency key for an order, if any
static Future<String?> getIdempotencyKey(int orderId) async {
  final db = await DBManager.database;

  final result = await db.query(
    'Orders',
    columns: ['IdempotencyKey'],
    where: 'OrderID = ?',
    whereArgs: [orderId],
  );

  if (result.isNotEmpty && result.first['IdempotencyKey'] != null) {
    return result.first['IdempotencyKey'] as String;
  }
  return null;
}



/// Clear idempotency key after successful payment
static Future<void> clearIdempotencyKey(int orderId) async {
  final db = await DBManager.database;

  await db.update(
    'Orders',
    {'IdempotencyKey': null},
    where: 'OrderID = ?',
    whereArgs: [orderId],
  );
}


/// Ensure we have an idempotency key for the order.
/// If none exists, generate and save one.
static Future<String> ensureIdempotencyKey(int orderId) async {
  final existingKey = await getIdempotencyKey(orderId);
  if (existingKey != null && existingKey.isNotEmpty) {
    return existingKey;
  }
  return await generateAndSaveIdempotencyKey(orderId);
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
