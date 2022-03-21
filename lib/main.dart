import 'package:flutter/material.dart';
import 'package:random_foods/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '随机一日三餐',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: const Color.fromRGBO(246, 246, 246, 1.0),
      ),
      home: const HomePage(),
    );
  }
}
