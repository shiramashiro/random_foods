import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:random_foods/models/food.dart';
import 'package:random_foods/service/database/db_operation.dart';
import 'package:random_foods/utils/callbacks.dart';
import 'package:random_foods/utils/picture_operation.dart';

class FoodsService {
  final DatabaseOp _databaseOp = DatabaseOp();
  final PictureOperation _pictureOp = PictureOperation();

  getRandom(int length) {
    return Random().nextInt(length);
  }

  Future _createTable() async {
    await _databaseOp.createTable(
      table: 'foods',
      fields: [
        TableField(name: 'id', type: 'integer primary key autoincrement'),
        TableField(name: 'name', type: 'text'),
        TableField(name: 'image', type: 'text'),
        TableField(name: 'times', type: 'integer'),
        TableField(name: 'price', type: 'double'),
        TableField(name: 'entryDate', type: 'text'),
        TableField(name: 'eatenDate', type: 'text'),
      ],
    );
  }

  void valid({
    required String? foodName,
    required XFile? file,
    required ValidSuccess success,
  }) {
    if (foodName != null && file != null) {
      success();
    } else {
      EasyLoading.showToast('请输入完整的信息！');
    }
  }

  storage({
    required XFile file,
    required OnImageStorage onImageStorage,
  }) async {
    String imgPath = await _pictureOp.writeImageIntoDir(await file.readAsBytes(), file.name);
    _databaseOp.dbExists('foods', isExists: () {
      _databaseOp.insert('foods', onImageStorage(imgPath).toJson());
      EasyLoading.showToast('保存成功');
    }, notExists: () async {
      await _createTable();
      _databaseOp.insert('foods', onImageStorage(imgPath).toJson());
      EasyLoading.showToast('初始化数据库，稍后再试');
    });
  }

  void display(QuerySuccess success) {
    _databaseOp.select('foods', success: (e) {
      success(e);
    });
  }

  void delete(int foodId) async {
    await _databaseOp.delete('foods', 'id = $foodId');
    EasyLoading.showToast('删除成功');
  }

  void update(Food food) {
    _databaseOp.update('foods', food.toJson(), 'id = ${food.id}');
  }
}
