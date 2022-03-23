import 'package:flutter/material.dart';
import 'package:random_foods/utils/callbacks.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    Key? key,
    required this.text,
    this.icon,
    this.onTap,
    this.isBorder = true,
    this.iconSize = 22,
    this.buttonPadding = 10,
    this.marginBottom = 5,
    this.marginLeft = 5,
    this.marginRight = 5,
    this.marginTop = 5,
  }) : super(key: key);

  final IconData? icon;
  final String text;
  final OnTap? onTap;
  final bool isBorder;
  final double iconSize;
  final double buttonPadding;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;

  Widget _createButton() {
    if (icon == null) {
      return Column(
        children: [Text(text)],
      );
    } else {
      return Column(
        children: [Icon(icon, size: iconSize), Text(text)],
      );
    }
  }

  Widget _createButtonContainer() {
    if (isBorder) {
      return Container(
        margin: EdgeInsets.only(top: marginTop, bottom: marginBottom, left: marginLeft, right: marginRight),
        padding: EdgeInsets.all(buttonPadding),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: InkWell(
          onTap: onTap,
          child: _createButton(),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top: marginTop, bottom: marginBottom, left: marginLeft, right: marginRight),
        child: InkWell(
          onTap: onTap,
          child: _createButton(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _createButtonContainer();
  }
}
