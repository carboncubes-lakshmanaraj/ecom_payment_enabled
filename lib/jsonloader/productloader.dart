import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ecom_payment/dbmanager/db.dart';
import 'package:sqflite/sqflite.dart';

Future<void> loadProductsFromJson() async {
  final jsonString = await rootBundle.loadString('assets/json/product.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  final List<dynamic> jsonData = jsonMap['dummyProducts'] ?? [];

  final db = await DBManager.database;

  // ✅ Step 1: Ensure currencies exist before inserting prices
  const supportedCurrencies = ['INR', 'USD', 'GBP'];
  for (final cur in supportedCurrencies) {
    await db.insert('currency', {
      'currencyId': cur,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  for (final item in jsonData) {
    // Check if product with the same title already exists
    final existingProducts = await db.query(
      'products',
      where: 'title = ?',
      whereArgs: [item['title']],
    );

    if (existingProducts.isNotEmpty) {
      print("ℹ️ Product already exists: ${item['title']}");
      continue;
    }

    // Step 2: Insert into products table
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

    // Step 3: Insert category links
    final categoryIds = item['categoryIds'] as List<dynamic>? ?? [];
    for (final catId in categoryIds) {
      await db.insert('product_categories', {
        'productId': productId,
        'categoryId': catId,
      });
    }

    // Step 4: Insert additional images
    final images = item['additionalImages'] as List<dynamic>? ?? [];
    for (final imagePath in images) {
      await db.insert('product_images', {
        'productId': productId,
        'imagePath': imagePath,
      });
    }

    // ✅ Step 5: Insert product prices with valid currency IDs
    final pricesMap = item['prices'] as Map<String, dynamic>?;

    if (pricesMap != null) {
      for (final entry in pricesMap.entries) {
        final currencyId = entry.key;
        final priceValue = (entry.value as num).toDouble();

        // Insert only if the currency exists
        if (supportedCurrencies.contains(currencyId)) {
          await db.insert('product_price', {
            'productId': productId,
            'currencyId': currencyId,
            'unitPrice': priceValue,
          });
        }
      }
    }
  }

  print("✅ Products loaded into database!");
}
