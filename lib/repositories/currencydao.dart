// ProductDao.dart or CurrencyDao.dart
import 'package:ecom_payment/dbmanager/db.dart';

class CurrencyDao {
  static Future<List<String>> getAllCurrencies() async {
    final db = await DBManager.database;
    final rows = await db.query('currency');

    return rows.map((e) => e['currencyId'] as String).toList();
  }
}
