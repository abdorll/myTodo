// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/function/navigate.dart';
import 'package:my_todo/screens/todo_home.dart';
import 'package:my_todo/utils/color.dart';
import 'package:my_todo/widgets/iconss.dart';
import 'package:my_todo/widgets/spacing.dart';
import 'package:my_todo/widgets/texts.dart';

class EachTodo extends StatefulWidget {
  EachTodo({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.completedStatus,
    Key? key,
  }) : super(key: key);
  String id, title, description, category;
  bool completedStatus;
  @override
  State<EachTodo> createState() => _EachTodoState();
}

class _EachTodoState extends State<EachTodo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YMargin(10),
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  child: CircleAvatar(
                    backgroundColor: white,
                    // ignore: sort_child_properties_last
                    child: widget.completedStatus == true
                        ? IconOf(Icons.done_all_rounded, 40, blue)
                        : IconOf(Icons.done_rounded, 40, blue),
                    radius: 25,
                  ),
                ),
                XMargin(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextOf(widget.title, 15, black, FontWeight.w600),
                    YMargin(5),
                    TextOf(widget.description, 13, black, FontWeight.w500)
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: blue2,
                          borderRadius: BorderRadius.circular(30)),
                      child: TextOf(widget.category, 11, blue, FontWeight.w400),
                    ),
                    YMargin(5),
                    Row(
                      children: [
                        InkWell(
                          child: widget.completedStatus == true
                              ? IconOf(
                                  Icons.check_circle_outline_rounded, 20, blue)
                              : IconOf(Icons.circle_outlined, 20, blue),
                          onTap: () {
                            setState(() {
                              widget.completedStatus = !widget.completedStatus;
                            });
                          },
                        ),
                        XMargin(20),
                        Consumer(builder: (context, ref, child) {
                          return InkWell(
                            child: IconOf(Icons.delete_forever, 20, red),
                            onTap: () {
                              setState(() {
                                ref.read(todoListProvider).removeWhere(
                                    (item) => item.id == widget.id);
                              });
                              Navigate.forwardForever(context, Tester());
                              Navigate.forwardForever(context, TodoHome());
                            },
                          );
                        }),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Tester extends StatelessWidget {
  const Tester({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
