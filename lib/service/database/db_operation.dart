import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

typedef OnSelectSuccess = void Function(Map<String, dynamic> result);
typedef OnInsertSuccess = Map<String, Object?> Function();

/// 在使用 SQLite 创建表时，需要字段名称以及字段的类型。因此，Field 属于一个约束，在创建表时发挥了重要作用。
class Field {
  String name;

  /// 字段类型主要有以下几种：整数：INTEGER；字符：TEXT；主键：PRIMARY KEY 或 PRIMARY KEY AUTOINCREMENT。
  String type;

  Field({required this.name, required this.type});
}

/// 主要通过 Operation 进行增删改查操作。Table 类是专门来创建表格的类。
class Table {
  /// 执行 SQL 语句之后获得一个 Database 对象，以供 Operation 能够使用增删改查。
  Future<Database> executeSql({
    required String sql,
    required String table,
  }) async {
    return await openDatabase(
      join(await getDatabasesPath(), table),
      onCreate: (db, version) => db.execute(sql),
      version: 1,
    );
  }

  /// 合并字段形成一份完整的 SQL 语句。
  String mergeSql(List<Field> fields, String table) {
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

  /// 创建完表格之后，返回一个 Operation，以便于后续操作。
  Future<DBOperation> create(DBOperation op, List<Field> fields) async {
    Database database = await executeSql(sql: mergeSql(fields, op.table), table: op.table);
    return op.setDatabase(database, op);
  }
}

class DBOperation {
  final String table;
  late Database _db;

  DBOperation({required this.table});

  DBOperation setDatabase(Database db, DBOperation op) {
    _db = db;
    return op;
  }

  Future<DBOperation> connect() async {
    _db = await openDatabase(join(await getDatabasesPath(), table));
    return this;
  }

  Future<DBOperation> createTable({required List<Field> fields}) {
    return Table().create(this, fields);
  }

  void insert({required OnInsertSuccess model}) async {
    await _db.insert(table, model(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> selectAll() async {
    return await _db.query(table);
  }
}
