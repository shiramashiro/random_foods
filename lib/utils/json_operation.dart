import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:random_foods/models/food.dart';

class JsonOperation {
  Future<List<Food>> load() async {
    String data = await rootBundle.loadString("assets/json/foods.json");
    List<Food> foods = [];
    for (Map<String, dynamic> map in jsonDecode(data)) {
      foods.add(Food.fromJson(map));
    }
    return foods;
  }
  //
  // Future update(Food food) {
  //
  // }
}
