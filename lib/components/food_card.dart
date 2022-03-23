import 'package:flutter/material.dart';
import 'package:random_foods/components/clickable_icon.dart';
import 'package:random_foods/models/food.dart';
import 'package:random_foods/utils/picture_operation.dart';

typedef DeleteItem = void Function();
typedef EditItem = void Function();

class FoodCard extends StatefulWidget {
  const FoodCard({
    Key? key,
    required this.food,
    required this.deleteItem,
    required this.editItem,
  }) : super(key: key);

  final Food? food;
  final DeleteItem deleteItem;
  final EditItem editItem;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  Widget _image = Container();

  @override
  void initState() {
    super.initState();
    _createImage();
  }

  void _createImage() {
    PictureOperation _po = PictureOperation();
    _po.readImageFromDir(widget.food!.image!).then((value) {
      setState(() {
        _image = Image.memory(value, height: 50, width: 50);
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              _image,
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food?.name ?? '还没决定',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '吃过 ${widget.food?.times ?? 0} 次',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      '${widget.food!.entryDate} 录入',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              ClickableIcon(
                icon: Icons.edit,
                onTap: widget.editItem,
              ),
              ClickableIcon(
                icon: Icons.delete,
                onTap: widget.deleteItem,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
