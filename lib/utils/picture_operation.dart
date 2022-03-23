import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PictureOperation {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> readImageFromPhoto() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<String> _getDirPath() async {
    Directory dir = await getApplicationSupportDirectory();
    return dir.path;
  }

  Future<String> writeImageIntoDir(Uint8List bytes, String imgName) async {
    String imagePath = '${await _getDirPath()}/$imgName';
    File(imagePath).writeAsBytes(bytes);
    return imagePath;
  }

  Future<Uint8List> readImageFromDir(String imgName) async {
    String imagePath = '${await _getDirPath()}/$imgName';
    return File(imagePath).readAsBytes();
  }
}
