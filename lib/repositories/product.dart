import 'package:ecom_payment/datas/product.dart';
import 'package:ecom_payment/dbmanager/db.dart';
import 'package:sqflite/sqflite.dart';

/// ===============================
/// Product DAO - CRUD Operations
/// ===============================
class ProductDao {
  /// Insert Product
  static Future<int> insertProduct(Product product) async {
    final db = await DBManager.database;

    int productId = await db.insert(
      'products',
      product.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    for (var catId in product.categoryIds) {
      await db.insert('product_categories', {
        'productId': productId,
        'categoryId': catId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    if (product.additionalImages != null) {
      for (var path in product.additionalImages!) {
        await db.insert('product_images', {
          'productId': productId,
          'imagePath': path,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    return productId;
  }

  /// Get All Products
  static Future<List<Product>> getAllProducts() async {
    final db = await DBManager.database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    List<Product> products = [];

    for (var map in maps) {
      int productId = map['id'];

      // Fetch product categories
      final catRows = await db.query(
        'product_categories',
        where: 'productId = ?',
        whereArgs: [productId],
      );
      List<int> categoryIds = catRows
          .map((row) => row['categoryId'] as int)
          .toList();

      // Fetch additional images
      final imgRows = await db.query(
        'product_images',
        where: 'productId = ?',
        whereArgs: [productId],
      );
      List<String> images = imgRows
          .map((row) => row['imagePath'] as String)
          .toList();

      // ✅ Fetch product prices from product_price
      final priceRows = await db.query(
        'product_price',
        where: 'productId = ?',
        whereArgs: [productId],
      );
      Map<String, double> prices = {};
      for (var priceRow in priceRows) {
        final currencyId = priceRow['currencyId'] as String;
        final unitPrice = (priceRow['unitPrice'] as num).toDouble();
        prices[currencyId] = unitPrice;
      }

      products.add(
        Product.fromMap(
          map,
          categoryIds: categoryIds,
          images: images,
          prices: prices,
        ),
      );
    }

    return products;
  }

  /// Update Product
  static Future<void> updateProduct(Product product) async {
    final db = await DBManager.database;

    if (product.id == null) {
      throw Exception("Product ID is required for update.");
    }

    await db.update(
      'products',
      product.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [product.id],
    );

    await db.delete(
      'product_categories',
      where: 'productId = ?',
      whereArgs: [product.id],
    );
    for (var catId in product.categoryIds) {
      await db.insert('product_categories', {
        'productId': product.id,
        'categoryId': catId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await db.delete(
      'product_images',
      where: 'productId = ?',
      whereArgs: [product.id],
    );
    if (product.additionalImages != null) {
      for (var path in product.additionalImages!) {
        await db.insert('product_images', {
          'productId': product.id,
          'imagePath': path,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  /// Delete Product
  static Future<void> deleteProduct(int productId) async {
    final db = await DBManager.database;
    await db.delete('products', where: 'id = ?', whereArgs: [productId]);
  }

  static Future<Product?> getProductById(int id) async {
    final db = await DBManager.database;

    final maps = await db.query('products', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;

    var map = maps.first;

    final catRows = await db.query(
      'product_categories',
      where: 'productId = ?',
      whereArgs: [id],
    );
    List<int> categoryIds = catRows
        .map((row) => row['categoryId'] as int)
        .toList();

    final imgRows = await db.query(
      'product_images',
      where: 'productId = ?',
      whereArgs: [id],
    );
    List<String> images = imgRows
        .map((row) => row['imagePath'] as String)
        .toList();

    // ✅ Fetch product prices from product_price
    final priceRows = await db.query(
      'product_price',
      where: 'productId = ?',
      whereArgs: [id],
    );
    Map<String, double> prices = {};
    for (var priceRow in priceRows) {
      final currencyId = priceRow['currencyId'] as String;
      final unitPrice = (priceRow['unitPrice'] as num).toDouble();
      prices[currencyId] = unitPrice;
    }

    return Product.fromMap(
      map,
      categoryIds: categoryIds,
      images: images,
      prices: prices,
    );
  }
}
