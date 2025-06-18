import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBManager {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<String> getDatabasePath() async {
    Directory dir =
        await getApplicationDocumentsDirectory(); // safer & permission-free
    return join(dir.path, "ecom.db");
  }

  static Future<Database> _initDB() async {
    String path = await getDatabasePath();

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Orders (
            OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
            Email TEXT NOT NULL,
            OrderDate TEXT NOT NULL DEFAULT (datetime('now')),
            TotalPrice REAL NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS OrderItems (
            OrderItemID INTEGER PRIMARY KEY AUTOINCREMENT,
            OrderID INTEGER NOT NULL,
            ProductTitle TEXT NOT NULL,
            ProductImage TEXT,
            SelectedSize TEXT,
            Quantity INTEGER NOT NULL DEFAULT 1,
            Price REAL NOT NULL,
            FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
          )
        ''');
      },
    );
  }
}
