import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TableField {
  String name;

  String type;

  TableField({required this.name, required this.type});
}

typedef DatabaseIsExists = void Function();

/// 操作表数据时，必须要连接数据库。
class Operation {
  Future<Database> getDatabase(String table) async {
    return await openDatabase(join(await getDatabasesPath(), table));
  }

  dbExists(String table, DatabaseIsExists isExists) async {
    bool dbExists = await databaseExists(table);
    if (dbExists) {
      isExists();
    } else {
      throw Exception('The $table database is not exists. please make sure you have created the database.');
    }
  }
}

/// 操作表数据相关的，各类增删改查。
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

  /// 创建表
  void createTable({
    required String table,
    required List<TableField> fields,
  }) async {
    await _executeSql(sql: _mergeSql(fields, table), table: table);
  }

  /// 删除表
  void deleteTable(String table) {
    super.dbExists(table, () async {
      deleteDatabase('${await getDatabasesPath()}/$table');
    });
  }

  void insert(String table, Map<String, Object?> values) {
    super.dbExists(table, () async {
      Database db = await super.getDatabase(table);
      db.insert(table, values).then((value) {
        db.close();
      });
    });
  }

  void select(String table) {
    super.dbExists(table, () async {
      Database db = await super.getDatabase(table);
      var s = await db.query(table);
      print(s);
    });
  }
}
