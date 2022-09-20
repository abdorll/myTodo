// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class IconOf extends StatelessWidget {
  IconOf(this.icon, this.size, this.color, {Key? key}) : super(key: key);
  IconData icon;
  double size;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
