// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:my_todo/widgets/texts.dart';

smallBtn(String text, Color textColor, Color btnColor, VoidCallback action) {
  return InkWell(
    onTap: () {
      action();
    },
    child: Container(
      decoration: BoxDecoration(
          color: btnColor, borderRadius: BorderRadius.circular(7)),
      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 14),
      child: TextOf(text, 16, textColor, FontWeight.w500),
    ),
  );
}
