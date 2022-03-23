import 'package:flutter/material.dart';
import 'package:random_foods/components/clickable_icon.dart';
import 'package:random_foods/components/food_card.dart';
import 'package:random_foods/models/food.dart';
import 'package:random_foods/service/foods_service.dart';

class ShowFoodsPage extends StatefulWidget {
  const ShowFoodsPage({Key? key}) : super(key: key);

  @override
  State<ShowFoodsPage> createState() => _ShowFoodsPageState();
}

class _ShowFoodsPageState extends State<ShowFoodsPage> {
  final FoodsService _service = FoodsService();
  late List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    _service.display((maps) {
      setState(() {
        foods = maps;
      });
    });
  }

  Widget _createTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('已有的食物'),
        ClickableIcon(
          icon: Icons.refresh,
          onTap: () {
            _service.display((maps) {
              setState(() {
                foods = maps;
              });
            });
          },
        ),
      ],
    );
  }

  Widget _createFoodCard(Food food) {
    return FoodCard(
      food: food,
      deleteItem: () {
        _service.delete(food.id!);
        _service.display((maps) {
          setState(() {
            foods = maps;
          });
        });
      },
      editItem: () {
      },
    );
  }

  List<Widget> _createFoodList() {
    var widgets = <Widget>[];
    for (Food food in foods) {
      widgets.add(_createFoodCard(food));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _createTitle(),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Column(
          children: _createFoodList(),
        ),
      ),
    );
  }
}
