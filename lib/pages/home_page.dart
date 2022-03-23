import 'package:flutter/material.dart';
import 'package:random_foods/components/text_icon_button.dart';
import 'package:random_foods/components/today_food.dart';
import 'package:random_foods/models/food.dart';
import 'package:random_foods/pages/add_foods_page.dart';
import 'package:random_foods/pages/show_foods_page.dart';
import 'package:random_foods/service/foods_service.dart';
import 'package:random_foods/utils/datetime_manager.dart';
import 'package:random_foods/utils/road_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FoodsService _service = FoodsService();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Widget _todayFood = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('随机一日三餐'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextIconButton(
                  onTap: () {
                    RoadMap.push(context, const AddFoodsPage());
                  },
                  icon: Icons.add,
                  text: '增加食物',
                ),
                TextIconButton(
                  onTap: () {
                    RoadMap.push(context, const ShowFoodsPage());
                  },
                  icon: Icons.emoji_food_beverage,
                  text: '已有食物',
                )
              ],
            ),
            Center(
              child: TextIconButton(
                onTap: () {
                  _service.display((foods) {
                    Food food = foods[_service.getRandom(foods.length)];
                    setState(() {
                      _todayFood = TodayFood(
                        food: food,
                        onTap: () {
                          var times = food.times;
                          times = times! + 1;
                          food.times = times;
                          food.eatenDate = DateTimeManager().getDateTime();
                          _service.update(food);
                          setState(() {
                            _todayFood = Container();
                          });
                        },
                      );
                    });
                  });
                },
                icon: Icons.query_builder,
                text: '今日随机',
              ),
            ),
            _todayFood,
          ],
        ),
      ),
    );
  }
}
