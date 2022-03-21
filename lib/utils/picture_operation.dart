import 'package:image_picker/image_picker.dart';

class PictureOperation {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> select() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  /// 1. 将突变上传到项目中
  /// 2. 提供一个回调函数，然后调用 json_operation，把 json 数据写入到文件中。
}
