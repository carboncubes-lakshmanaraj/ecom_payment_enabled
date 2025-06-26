import 'package:ecom_payment/datas/paymentlog.dart';
import 'package:ecom_payment/dbmanager/db.dart';

class PaymentLogRepository {
  static Future<void> insertLog(PaymentLog log) async {
    final db = await DBManager.database;
    await db.insert('payment_logs', log.toMap());
  }

  static Future<List<PaymentLog>> getLogsByOrder(int orderId) async {
    final db = await DBManager.database;
    final result = await db.query(
      'payment_logs',
      where: 'order_id = ?',
      whereArgs: [orderId],
      orderBy: 'created_at DESC',
    );
    return result.map((e) => PaymentLog.fromMap(e)).toList();
  }
}
