import 'package:flutter/material.dart';
import 'package:random_foods/components/text_icon_button.dart';
import 'package:random_foods/models/food.dart';
import 'package:random_foods/utils/callbacks.dart';
import 'package:random_foods/utils/picture_operation.dart';

class TodayFood extends StatefulWidget {
  const TodayFood({
    Key? key,
    required this.food,
    required this.onTap,
  }) : super(key: key);

  final Food food;
  final OnTap onTap;

  @override
  State<TodayFood> createState() => _TodayFoodState();
}

class _TodayFoodState extends State<TodayFood> {
  Widget _image = Container();
  String eatOrNot = '还没开始吃哦！';

  @override
  void initState() {
    super.initState();
    _createImage();
  }

  @override
  void didUpdateWidget(covariant TodayFood oldWidget) {
    super.didUpdateWidget(oldWidget);
    _createImage();
  }

  void _createImage() {
    PictureOperation _po = PictureOperation();
    _po.readImageFromDir(widget.food.image!).then((value) {
      setState(() {
        _image = ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.memory(value, height: 50, width: 50));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _image,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.name!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '吃过 ${widget.food.times} 次',
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    '${widget.food.entryDate!} 录入',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              TextIconButton(text: 'OK', onTap: widget.onTap)
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eatOrNot),
                Text(widget.food.eatenDate != null ? '${widget.food.eatenDate} 吃过一次': '还没吃过'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
