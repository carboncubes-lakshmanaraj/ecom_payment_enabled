// subcategory_db.dart

import 'package:ecom_payment/datas/categoryandsubcat.dart';
import 'package:ecom_payment/dbmanager/db.dart';
import 'package:sqflite/sqflite.dart';
// adjust import path if needed

class SubCategoryDB {
  static Future<void> insertSubCategory(SubCategory subCategory) async {
    final db = await DBManager.database;
    await db.insert(
      'sub_categories',
      subCategory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<SubCategory>> getAllSubCategories() async {
    final db = await DBManager.database;
    final maps = await db.query('sub_categories');
    return maps.map((map) => SubCategory.fromMap(map)).toList();
  }

  static Future<SubCategory?> getSubCategoryById(int id) async {
    final db = await DBManager.database;
    final maps = await db.query(
      'sub_categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return SubCategory.fromMap(maps.first);
    }
    return null;
  }

  static Future<void> updateSubCategory(SubCategory subCategory) async {
    final db = await DBManager.database;
    await db.update(
      'sub_categories',
      subCategory.toMap(),
      where: 'id = ?',
      whereArgs: [subCategory.id],
    );
  }

  static Future<void> deleteSubCategory(int id) async {
    final db = await DBManager.database;
    await db.delete('sub_categories', where: 'id = ?', whereArgs: [id]);
  }
}
