import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TableField {
  String name;
  String type;

  TableField({
    required this.name,
    required this.type,
  });
}

class TableOp {
  void _executeSql({
    required String sql,
    required String table,
  }) async {
    await openDatabase(
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

  void create({
    required String table,
    required List<TableField> fields,
  }) {
    _executeSql(sql: _mergeSql(fields, table), table: table);
  }
}
