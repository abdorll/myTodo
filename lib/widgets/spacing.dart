import 'package:flutter/material.dart';

class XMargin extends StatelessWidget {
  final double x;
  // ignore: use_key_in_widget_constructors
  const XMargin(this.x);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x);
  }
}

class YMargin extends StatelessWidget {
  final double y;
  // ignore: use_key_in_widget_constructors
  const YMargin(this.y);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y);
  }
}
