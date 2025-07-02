import 'dart:convert';
import 'package:ecom_payment/datas/categoryandsubcat.dart';
import 'package:ecom_payment/datas/dummydata.dart';
import 'package:ecom_payment/dbmanager/db.dart';
import 'package:ecom_payment/repositories/category.dart';
import 'package:ecom_payment/repositories/subCtegory.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

Future<void> loadsubCategoriesFromJson() async {
  final db = await DBManager.database;

  // Check if categories already exist
  final existing = await db.query('sub_categories');
  if (existing.isNotEmpty) {
    print("subCategories already exist, skipping JSON load.");
    return;
  }

  print("Loading subCategories from JSON...");

  // Read JSON file
  final String jsonString = await rootBundle.loadString(
    'assets/json/subcat.json',
  );
  final List<dynamic> jsonList = json.decode(jsonString);

  for (var item in jsonList) {
    try {
      final category = SubCategory(id: item['id'], title: item['title']);

      await SubCategoryDB.insertSubCategory(category);
    } catch (e) {
      print("Error inserting subCategory: $e");
    }
  }

  print("Categories loaded from JSON and inserted into DB.");
}
