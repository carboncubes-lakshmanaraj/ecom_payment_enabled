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
    Directory? extDir = await getExternalStorageDirectory();
    return join(extDir!.path, "ecom.db");
  }

  static Future<Database> _initDB() async {
    String path = await getDatabasePath();

    return await openDatabase(
      path,
      version: 8, // 🔼 bump version for new tables
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        // Existing tables
        await db.execute('''
        CREATE TABLE IF NOT EXISTS Orders (
          OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
          Email TEXT NOT NULL,
          OrderDate TEXT NOT NULL DEFAULT (datetime('now')),
          TotalPrice REAL NOT NULL,
          OrderStatus TEXT NOT NULL DEFAULT 'Pending',
          CurrencyID TEXT NOT NULL DEFAULT 'INR',
          PaymentIntentID TEXT,
            IdempotencyKey TEXT,
           FOREIGN KEY (CurrencyID) REFERENCES currency(currencyId)
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

        await db.execute('''
        CREATE TABLE IF NOT EXISTS payment_logs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          order_id INTEGER,
          direction TEXT,
          payload TEXT,
          created_at TEXT,
          FOREIGN KEY (order_id) REFERENCES Orders(OrderID) ON DELETE CASCADE
        )
      ''');

        // 🔥 NEW: Product-related tables

        await db.execute('''
          CREATE TABLE IF NOT EXISTS categories (
            id INTEGER PRIMARY KEY ,
            title TEXT,
            image TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS sub_categories (
            id INTEGER PRIMARY KEY  ,
            title TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            productDescrip TEXT,
            moreinfo TEXT,
            mrpPrice REAL,
            percentageOff INTEGER,
            subCategoryId INTEGER,
            dealsOfTheDay INTEGER,
            trendingProducts INTEGER,
            productImage TEXT,
            FOREIGN KEY (subCategoryId) REFERENCES sub_categories(id)
          );
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS product_categories (
            productId INTEGER,
            categoryId INTEGER,
            PRIMARY KEY (productId, categoryId),
            FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE,
            FOREIGN KEY (categoryId) REFERENCES categories(id) ON DELETE CASCADE
          );
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS product_images (
            productId INTEGER,
            imagePath TEXT,
            PRIMARY KEY (productId, imagePath),
            FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE
          );
        ''');

        ///currency ...
        ///
        await db.execute('''
  CREATE TABLE IF NOT EXISTS currency (
    currencyId TEXT PRIMARY KEY
  );
''');

        await db.execute('''
  CREATE TABLE IF NOT EXISTS product_price (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    productId INTEGER NOT NULL,
    currencyId TEXT NOT NULL,
    unitPrice REAL NOT NULL,
    UNIQUE (productId, currencyId),
    FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (currencyId) REFERENCES currency(currencyId) ON DELETE CASCADE
  );
''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            "ALTER TABLE Orders ADD COLUMN OrderStatus TEXT DEFAULT 'Pending'",
          );
        }
        if (oldVersion < 3) {
          await db.execute(
            "ALTER TABLE Orders ADD COLUMN PaymentIntentID TEXT",
          );
        }
        if (oldVersion < 4) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS payment_logs (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              order_id INTEGER,
              direction TEXT,
              payload TEXT,
              created_at TEXT,
              FOREIGN KEY (order_id) REFERENCES Orders(OrderID) ON DELETE CASCADE
            )
          ''');
        }
        if (oldVersion < 5) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS categories (
              id INTEGER PRIMARY KEY ,
              title TEXT,
              image TEXT
            );
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS sub_categories (
              id INTEGER PRIMARY KEY ,
              title TEXT
            );
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS products (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              productDescrip TEXT,
              moreinfo TEXT,
              mrpPrice REAL,
              percentageOff INTEGER,
              subCategoryId INTEGER,
              dealsOfTheDay INTEGER,
              trendingProducts INTEGER,
              productImage TEXT,
              FOREIGN KEY (subCategoryId) REFERENCES sub_categories(id)
            );
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS product_categories (
              productId INTEGER,
              categoryId INTEGER,
              PRIMARY KEY (productId, categoryId),
              FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE,
              FOREIGN KEY (categoryId) REFERENCES categories(id) ON DELETE CASCADE
            );
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS product_images (
              productId INTEGER,
              imagePath TEXT,
              PRIMARY KEY (productId, imagePath),
              FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE
            );
          ''');
        }
        if (oldVersion < 6) {
          await db.execute('''
    CREATE TABLE IF NOT EXISTS currency (
      currencyId TEXT PRIMARY KEY
    );
  ''');

          await db.execute('''
    CREATE TABLE IF NOT EXISTS product_price (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      productId INTEGER NOT NULL,
      currencyId TEXT NOT NULL,
      unitPrice REAL NOT NULL,
      UNIQUE (productId, currencyId),
      FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE,
      FOREIGN KEY (currencyId) REFERENCES currency(currencyId) ON DELETE CASCADE
    );
  ''');
        }
        if (oldVersion < 7) {
          await db.execute(
            "ALTER TABLE Orders ADD COLUMN CurrencyID TEXT NOT NULL DEFAULT 'INR'",
          );
        }
        if (oldVersion < 8) {
          await db.execute("ALTER TABLE Orders ADD COLUMN IdempotencyKey TEXT");
        }
      },
    );
  }
}
