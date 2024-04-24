import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ets_cinema_app/database/watch_item_db.dart';

class DatabaseService {
  Database? _database;

  // Returns a future placeholder that'll eventually be filled with a database
  Future<Database> get database async {

    // Check if the database already exists
    if (_database != null){
      return _database!;
    }

    // Initialize database
    _database = await _initialize();
    return _database!;
  }

  // Get the default database location/path of the device
  Future<String> get fullPath async {
    const name = 'watch_list.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  // Initialize database on the default location/path
  Future<Database> _initialize() async {
    final path = await fullPath;
    // Open database at a specified path
    var database = await openDatabase(
      path,
      // Version of the dataset
      version: 1,
      // Create database using this function if it does not exist yet
      onCreate: (db, version) async {
        // Here, instead of directly calling createTable, we'll create an instance of NotesDB and call createTable on that instance.
        final watchItemDB = WatchItemDB();
        await watchItemDB.createTable(db);
      },
      singleInstance: true,
    );
    return database;
  }
}
