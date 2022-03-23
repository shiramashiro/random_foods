import 'package:flutter/material.dart';
import 'package:random_foods/components/text_icon_button.dart';
import 'package:random_foods/models/food.dart';
import 'package:random_foods/utils/picture_operation.dart';

class TodayFood extends StatefulWidget {
  const TodayFood({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Food food;

  @override
  State<TodayFood> createState() => _TodayFoodState();
}

class _TodayFoodState extends State<TodayFood> {
  Widget _image = Container();

  @override
  void initState() {
    super.initState();
    _createImage();
  }

  void _createImage() {
    PictureOperation _po = PictureOperation();
    _po.readImageFromDir(widget.food.image!).then((value) {
      setState(() {
        _image = Image.memory(value, height: 50, width: 50);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Row(
              children: [
                _image,
                Column(
                  children: [
                    Text(
                      widget.food.name!,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '吃过 ${widget.food.times!} 次',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      '${widget.food.entryDate!} 录入',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                TextIconButton(text: 'OK', onTap: () {},)
              ],
            )
          ],
        ),
      ],
    );
  }
}
