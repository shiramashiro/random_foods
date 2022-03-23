import 'package:flutter/material.dart';
import 'package:random_foods/models/food.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Food? food;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                food?.name ?? '还没决定',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '吃过 ${food?.times ?? 0} 次',
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
