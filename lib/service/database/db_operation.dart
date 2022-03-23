import 'package:random_foods/models/food.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TableField {
  String name;

  String type;

  TableField({required this.name, required this.type});
}

typedef DatabaseIsExists = void Function();
typedef DatabaseNotExists = void Function();
typedef QuerySuccess = void Function(List<Food> foods);

class Operation {
  Future<Database> getDatabase(String table) async {
    return await openDatabase(join(await getDatabasesPath(), table));
  }

  void dbExists(
    String table, {
    required DatabaseIsExists isExists,
    DatabaseNotExists? notExists,
  }) async {
    if (await databaseExists(table)) {
      isExists();
    } else {
      if (notExists != null) notExists();
    }
  }
}

class DatabaseOp extends Operation {
  Future<Database> _executeSql({
    required String sql,
    required String table,
  }) async {
    return await openDatabase(
      join(await getDatabasesPath(), table),
      onCreate: (db, version) => db.execute(sql),
      version: 1,
    );
  }

  String _mergeSql(
    List<TableField> fields,
    String table,
  ) {
    String sql = 'CREATE TABLE $table(';
    for (int i = 0; i < fields.length; i++) {
      String fragment = '${fields[i].name} ${fields[i].type}';
      if (i == fields.length - 1) {
        sql += fragment;
      } else {
        sql += fragment + ',';
      }
    }
    return sql += ')';
  }

  Future createTable({
    required String table,
    required List<TableField> fields,
  }) async {
    await _executeSql(sql: _mergeSql(fields, table), table: table);
  }

  void deleteTable(String table) {
    dbExists(table, isExists: () async {
      deleteDatabase('${await getDatabasesPath()}/$table');
    });
  }

  void insert(String table, Map<String, Object?> values) {
    dbExists(table, isExists: () async {
      Database db = await super.getDatabase(table);
      await db.insert(table, values);
      db.close();
    });
  }

  void select(
    String table, {
    required QuerySuccess success,
    String? where,
  }) {
    dbExists(table, isExists: () async {
      var db = await super.getDatabase(table);
      var data = await db.query(table, where: where);
      var list = <Food>[];
      for (var element in data) {
        list.add(Food.fromJson(element));
      }
      success(list);
      db.close();
    });
  }
}
