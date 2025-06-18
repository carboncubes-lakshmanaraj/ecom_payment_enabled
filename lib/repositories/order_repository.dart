import 'package:ecom_payment/dbmanager/db.dart';
import 'package:ecom_payment/datas/cartitem.dart';

class OrderRepository {
  static Future<int> createOrder({
    required String email,
    required List<CartItem> cartItems,
  }) async {
    final db = await DBManager.database;

    double total = cartItems.fold(
      0,
      (sum, item) => sum + item.product.discountedPrice.round(),
    );

    // Insert into Orders table
    int orderId = await db.insert("Orders", {
      'Email': email,
      'TotalPrice': total,
    });

    // Insert into OrderItems table
    for (var item in cartItems) {
      await db.insert("OrderItems", {
        'OrderID': orderId,
        'ProductTitle': item.product.title,
        'ProductImage': item.product.productImage,
        'SelectedSize': item.selectedSize,
        'Quantity': 1, // or item.qty if you support qty
        'Price': item.product.discountedPrice.round(),
      });
    }

    return orderId;
  }

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

    return {'order': order.first, 'items': items};
  }
}
