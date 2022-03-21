import 'package:flutter/material.dart';
import 'package:random_foods/utils/callbacks.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final OnTap? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [Icon(icon), Text(text)],
        ),
      ),
    );
  }
}
