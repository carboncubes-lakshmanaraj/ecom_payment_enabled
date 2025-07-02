// category_db.dart

import 'package:ecom_payment/datas/categoryandsubcat.dart';
import 'package:ecom_payment/dbmanager/db.dart';
import 'package:sqflite/sqflite.dart';

// adjust import path if needed

class CategoryDB {
  static Future<void> insertCategory(Category category) async {
    final db = await DBManager.database;
    await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Category>> getAllCategories() async {
    final db = await DBManager.database;
    final maps = await db.query('categories');
    return maps.map((map) => Category.fromMap(map)).toList();
  }

  static Future<Category?> getCategoryById(int id) async {
    final db = await DBManager.database;
    final maps = await db.query('categories', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Category.fromMap(maps.first);
    }
    return null;
  }

  static Future<void> updateCategory(Category category) async {
    final db = await DBManager.database;
    await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  static Future<void> deleteCategory(int id) async {
    final db = await DBManager.database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
