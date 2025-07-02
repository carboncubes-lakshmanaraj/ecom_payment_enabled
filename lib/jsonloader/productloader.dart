import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ecom_payment/dbmanager/db.dart';

Future<void> loadProductsFromJson() async {
  final jsonString = await rootBundle.loadString('assets/json/product.json');

  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  final List<dynamic> jsonData = jsonMap['dummyProducts'] ?? [];

  final db = await DBManager.database;

  for (final item in jsonData) {
    final productId = await db.insert('products', {
      'title': item['title'],
      'moreinfo': item['moreinfo'],
      'productDescrip': item['productDescrip'],
      'mrpPrice': item['mrpPrice'],
      'percentageOff': item['percentageOff'],
      'subCategoryId': item['subCategoryId'],
      'dealsOfTheDay': item['dealsOfTheDay'] ? 1 : 0,
      'trendingProducts': item['trendingProducts'] ? 1 : 0,
      'productImage': item['productImage'],
    });

    final categoryIds = item['categoryIds'] as List<dynamic>? ?? [];
    for (final catId in categoryIds) {
      await db.insert('product_categories', {
        'productId': productId,
        'categoryId': catId,
      });
    }

    final images = item['additionalImages'] as List<dynamic>? ?? [];
    for (final imagePath in images) {
      await db.insert('product_images', {
        'productId': productId,
        'imagePath': imagePath,
      });
    }
  }

  print("✅ Products loaded into database!");
}
