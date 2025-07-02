import 'dart:convert';
import 'package:ecom_payment/datas/categoryandsubcat.dart';
import 'package:ecom_payment/dbmanager/db.dart';
import 'package:ecom_payment/repositories/category.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

Future<void> loadCategoriesFromJson() async {
  final db = await DBManager.database;

  // Check if categories already exist
  final existing = await db.query('categories');
  if (existing.isNotEmpty) {
    print("Categories already exist, skipping JSON load.");
    return;
  }

  print("Loading Categories from JSON...");

  // Read JSON file
  final String jsonString = await rootBundle.loadString(
    'assets/json/category.json',
  );
  final List<dynamic> jsonList = json.decode(jsonString);

  for (var item in jsonList) {
    try {
      final category = Category(
        id: item['id'],
        title: item['title'],
        image: item['image'],
      );

      await CategoryDB.insertCategory(category);
    } catch (e) {
      print("Error inserting Category: $e");
    }
  }

  print("Categories loaded from JSON and inserted into DB.");
}
