import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "TheeDatabasey.db";

  static const _databaseVersion = 1;
  static const table = 'the_table';
  static const showTable = 'showTable';
  static const movieTable = 'movieTable';

  static const columnGenre = 'genres';
  static const columnId = 'id';
  static const columnIsShow = 'isShow';
  static const columnTitle = 'name';
  static const columnoverView = 'overView';
  static const columnposterPath = 'posterPath';
  static const columnreleaseDate = 'releaseDate';
  static const columnreleaseTime = 'time';
  static const columnvoteAverage = 'voteAverage';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnGenre TEXT NOT NULL,
            $columnId TEXT NOT NULL,
            $columnIsShow INTEGER NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnoverView TEXT NOT NULL,
            $columnposterPath TEXT NOT NULL,
            $columnreleaseDate TEXT NOT NULL,
            $columnreleaseTime TEXT NOT NULL,
            $columnvoteAverage DOUBLE NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $showTable (
            $columnGenre TEXT NOT NULL,
            $columnId TEXT NOT NULL,
            $columnIsShow INTEGER NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnoverView TEXT NOT NULL,
            $columnposterPath TEXT NOT NULL,
            $columnreleaseDate TEXT NOT NULL,
            $columnreleaseTime TEXT NOT NULL,
            $columnvoteAverage DOUBLE NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $movieTable (
            $columnGenre TEXT NOT NULL,
            $columnId TEXT NOT NULL,
            $columnIsShow INTEGER NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnoverView TEXT NOT NULL,
            $columnposterPath TEXT NOT NULL,
            $columnreleaseDate TEXT NOT NULL,
            $columnreleaseTime TEXT NOT NULL,
            $columnvoteAverage DOUBLE NOT NULL
          )
          ''');
  }


  Future<int> insert(Map<String, dynamic> row,String table) async {
    Database db = await instance.database as Database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String query) async {
    Database db = await instance.database as Database;
    return await db.query(query);
  }

  Future<List<Map<String, dynamic>>> querySelect(String query,String id) async {
    Database db = await instance.database as Database;
    return await db.query(query,where:'$columnId = ?',whereArgs: [id]);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database as Database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(String table,String id) async {
    Database db = await instance.database as Database;
    return await db.delete(table,where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll(String table) async {
    Database db = await instance.database as Database;
    return await db.delete(table);
  }
}
