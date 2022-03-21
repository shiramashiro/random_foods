import 'dart:math';

import 'package:random_foods/models/food.dart';
import 'package:random_foods/utils/json_operation.dart';

class RandomFoods {
  final JsonOperation _jo = JsonOperation();

  Future<Food> getFood() async {
    List<Food> foods = await _jo.load();
    return foods[Random().nextInt(foods.length)];
  }
}
