import 'package:image_picker/image_picker.dart';
import 'package:random_foods/service/database/db_operation.dart';
import 'package:random_foods/utils/callbacks.dart';
import 'package:random_foods/utils/picture_operation.dart';

class SaveFoodService {
  final DatabaseOp _databaseOp = DatabaseOp();
  final PictureOperation _pictureOp = PictureOperation();

  Future _createTable() async {
    await _databaseOp.createTable(
      table: 'foods',
      fields: [
        TableField(name: 'id', type: 'integer primary key autoincrement'),
        TableField(name: 'name', type: 'text'),
        TableField(name: 'image', type: 'text'),
        TableField(name: 'times', type: 'integer'),
        TableField(name: 'entryDate', type: 'text'),
        TableField(name: 'eatenDate', type: 'text'),
      ],
    );
  }

  storage({
    required XFile file,
    required OnImageStorage onImageStorage,
  }) async {
    _pictureOp.writeImageIntoDir(await file.readAsBytes(), file.name).then((imgPath) {
      _databaseOp.dbExists('foods', isExists: () {
        _databaseOp.insert('foods', onImageStorage(imgPath).toJson());
      }, notExists: () {
        _createTable().then((value) {
          _databaseOp.insert('foods', onImageStorage(imgPath).toJson());
        });
      });
    });
  }

  display() {
    _databaseOp.select('foods', success: (e) {
      print(e);
    });
  }
}
