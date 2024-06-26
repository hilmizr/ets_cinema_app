import 'dart:async';

import 'package:ets_cinema_app/database/database_service.dart';
import 'package:ets_cinema_app/model/watch_item.dart';
import 'package:sqflite/sqflite.dart';

class WatchItemDB {
  final tableName = 'watch_item';

  Future<void> createTable(Database database) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await database.execute("""
      CREATE TABLE IF NOT EXISTS $tableName (
      ${WatchItemFields.id} $idType,
      ${WatchItemFields.title} $textType,
      ${WatchItemFields.release_date} $textType,
      ${WatchItemFields.cover_img} $textType,
      ${WatchItemFields.description} $textType,
      ${WatchItemFields.time} $textType
      )
      """);
  }

  Future<WatchItem> create(WatchItem watchItem) async {
    final database = await DatabaseService().database;

    // Id alway generated by the database
    final id = await database.insert(tableWatchItem, watchItem.toJson());
    return watchItem.copy(id: id);
  }

  Future<WatchItem> viewWatchItem(int id) async {
    final database = await DatabaseService().database;
    final maps = await database.query(
      tableWatchItem,
      columns: WatchItemFields.values,

      // Prevents SQL Injection attacks
      where: '${WatchItemFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return WatchItem.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<WatchItem>> viewAllWatchItem() async {
    final database = await DatabaseService().database;
    final orderBy = '${WatchItemFields.time} ASC';
    final result = await database.query(tableWatchItem, orderBy: orderBy);
    return result.map((json) => WatchItem.fromJson(json)).toList();
  }

  Future<int> update(WatchItem watchItem) async {
    final database = await DatabaseService().database;
    return database.update(tableWatchItem, watchItem.toJson(),
        where: '${WatchItemFields.id} = ?', whereArgs: [watchItem.id]);
  }

  Future<int> delete(int id) async {
    final database = await DatabaseService().database;
    return await database.delete(
      tableWatchItem,
      where: '${WatchItemFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final database = await DatabaseService().database;
    database.close();
  }
}
