import 'package:random_foods/models/food.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Field {
  String name;
  String type;

  Field({required this.name, required this.type});
}

class DBOperation {
  String _sql = '';
  String tableName;
  late Database _database;

  DBOperation({required this.tableName});

  DBOperation createTable({
    required List<Field> fields,
  }) {
    _sql = 'CREATE TABLE $tableName(';
    for (int i = 0; i < fields.length; i++) {
      String fragment = '${fields[i].name} ${fields[i].type}';
      if (i == fields.length - 1) {
        _sql += fragment;
      } else {
        _sql += fragment + ',';
      }
    }
    _sql += ')';
    return this;
  }

  Future<DBOperation> execute() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), tableName),
      onCreate: (db, version) {
        return db.execute(_sql);
      },
      version: 1,
    );
    return this;
  }

  Future<DBOperation> insert(Food data) async {
    await _database.insert(
      tableName,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return this;
  }

  void query() async {
    List<Map<String, dynamic>> maps = await _database.query(tableName);
    List.generate(maps.length, (i) {
      print(Food(
        name: maps[i]['name'],
      ).name);
    });
  }
}
