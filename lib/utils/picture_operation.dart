import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PictureOperation {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> readImageFromPhoto() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<String> _getDir() async {
    Directory dir = await getApplicationSupportDirectory();
    return dir.path;
  }

  writeImageIntoDir(Uint8List bytes, String imgName, {String imgFormat = 'jpg'}) async {
    String path = await _getDir();
    File('$path/$imgName.$imgFormat').writeAsBytes(bytes);
  }

  Future<Uint8List> readImageFromDir(String imgName, {String imgFormat = 'jpg'}) async {
    String path = await _getDir();
    return File('$path/$imgName.$imgFormat').readAsBytes();
  }
}
