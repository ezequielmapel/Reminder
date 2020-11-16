import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseSqflite {
  final String databaseName = 'reminder_01.db';
  final String databasePath = '';
  Database database;

  setup() async {
    return this.database = await openDatabase(
      path.join(await getDatabasesPath(), this.databaseName),
    );
  }

  createTable(String tableName, String values) async {
    String sql = 'CREATE TABLE IF NOT EXISTS ${tableName} (${values})';

    if (this.database.isOpen) {
      //await this.database.execute("DROP TABLE ${tableName}");
      await this.database.execute(sql);
    }
  }

  insertInTable(String tableName, Map<String, dynamic> values,
      ConflictAlgorithm conflictAlgorithm) async {
    if (this.database.isOpen) {
      await this
          .database
          .insert(tableName, values, conflictAlgorithm: conflictAlgorithm);
    }
  }

  Future<List> getValuesFromTable(String tableName) async {
    if (this.database != null && this.database.isOpen) {
      return await this.database.query(tableName);
    }
  }

  Future<List> getWithName(String tableName, value) async {
    return await this
        .database
        .query(tableName, where: "name = ?", whereArgs: [value]);
  }

  Future<List> getValueFromTable(String tableName, String where, List<String> predicate) async {
    return await this.database.query(tableName, where: where, whereArgs: predicate);
  }

  updateTable(String tableName, Map<String, dynamic> values) async {
    return await this.database.update(tableName, values,
        where: "name = ?", whereArgs: [values["name"]]);
  }
}
