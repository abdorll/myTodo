// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_todo/function/navigate.dart';
import 'package:my_todo/screens/intro_screen.dart';
import 'package:my_todo/screens/todo_home.dart';
import 'package:my_todo/utils/color.dart';
import 'package:my_todo/utils/constants.dart';
import 'package:my_todo/widgets/iconss.dart';

class SplashScren extends StatefulWidget {
  const SplashScren({Key? key}) : super(key: key);

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  void nextPage() {
    Future.delayed(Duration(seconds: 3), () async {
      var openBox = await Hive.openBox(userBox);
      openBox.get(recognisedUserKey) == true
          ? Navigate.forwardForever(context, TodoHome())
          : Navigate.forwardForever(context, IntroScreen());
    });
  }

  @override
  void initState() {
    nextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: blue, borderRadius: BorderRadius.circular(10)),
          child: IconOf(Icons.event_available_rounded, 60, white),
        ),
      ),
    );
  }
}
