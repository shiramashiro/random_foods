import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TableField {
  String name;

  String type;

  TableField({required this.name, required this.type});
}

/// 操作表数据时，必须要连接数据库。
class Operation {
  Future<Database> getDatabase(String table) async {
    return await openDatabase(join(await getDatabasesPath(), table));
  }
}

/// 操作表相关的。包括创建表、删除表。
class TableOp {
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
  void create({
    required String table,
    required List<TableField> fields,
  }) async {
    await _executeSql(sql: _mergeSql(fields, table), table: table);
  }

  /// 删除表
  void delete(String table) async => deleteDatabase('${await getDatabasesPath()}/$table');
}

/// 操作表数据相关的，各类增删改查。
class DataOp extends Operation {}
