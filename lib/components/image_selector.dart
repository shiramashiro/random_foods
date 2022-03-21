import 'package:flutter/material.dart';
import 'package:random_foods/utils/callbacks.dart';
import 'package:random_foods/utils/picture_operation.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({
    Key? key,
    this.width = 150,
    this.height = 150,
    this.iconSize = 30,
    this.onImagePicked,
  }) : super(key: key);

  final double width;
  final double height;
  final double iconSize;
  final OnImagePicked? onImagePicked;

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  XFile? _imgFile;
  Widget _pickImg = Container();

  void _createSelectedImage() {
    _imgFile?.readAsBytes().then((value) {
      _pickImg = Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image.memory(value, width: widget.width, height: widget.height, fit: BoxFit.cover),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            PictureOperation().select().then((value) {
              setState(() => _imgFile = value);
              if (widget.onImagePicked != null) widget.onImagePicked!(value!);
              _createSelectedImage();
            });
          },
          child: Container(
            width: 150,
            height: 150,
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(Icons.add, size: widget.iconSize),
          ),
        ),
        _pickImg,
      ],
    );
  }
}
