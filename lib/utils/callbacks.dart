import 'package:image_picker/image_picker.dart';
import 'package:random_foods/models/food.dart';

typedef OnTap = void Function();
typedef OnImagePicked = void Function(XFile e);
typedef OnImageStorage = Food Function(String imgPath);