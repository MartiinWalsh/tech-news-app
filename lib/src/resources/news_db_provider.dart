import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  //Todo: store and fetch top ids
  Future<List<int>> fetchTopIds() {
    return null;
  }

  void init() async {
    // Returns a reference to a directory on the device, using path_provider package
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");

    // Create db at given path if it doesn't exist or open it
    // version is an optional param to specify the schema version
    // onCreate called first time user starts application
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      // execute function : Execute an SQL query with no return value
      newDb.execute("""
        CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER, 
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
      """);
    });
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    db.insert("Items", item.toMap());
  }
}

// To prevent multiple db being opened
final newsDbProvider = NewsDbProvider();
