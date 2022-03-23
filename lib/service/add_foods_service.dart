import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:random_foods/utils/picture_operation.dart';

class AddFoodsService {
  final PictureOperation _pictureOp = PictureOperation();

  // 第一次使用本程序，需要创建 foods 表
  void initTable() {

  }

  bool fileExists(XFile? file) {
    return file == null ? false : true;
  }

  Future<bool> dbExists() async {
    return await databaseExists('foods');
  }

  // 保存数据到数据库
  // 保存的时候确认是不是第一次使用程序，如果不是就要创建数据库。
  // 如果用户插入了图片，连同插入图片，如果用户没有插入图片，就不保存图片到目录，也不保存图片的路径到数据库。
  void deposit(XFile? file) async {
    bool isDbExists = await dbExists();
    if (isDbExists) {
      if (fileExists(file)) {

      } else {

      }
    } else {

    }
  }
}