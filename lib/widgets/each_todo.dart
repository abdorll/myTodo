// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/function/helpers.dart';
import 'package:my_todo/function/navigate.dart';
import 'package:my_todo/screens/todo_home.dart';
import 'package:my_todo/utils/color.dart';
import 'package:my_todo/widgets/iconss.dart';
import 'package:my_todo/widgets/spacing.dart';
import 'package:my_todo/widgets/texts.dart';

class EachTodo extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() => _EachTodoState();
}

class _EachTodoState extends ConsumerState<EachTodo> {
  String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                      TextOf(
                        widget.title,
                        15,
                        black,
                        FontWeight.w600,
                        align: TextAlign.left,
                      ),
                      YMargin(5),
                      TextOf(widget.description, 13, black, FontWeight.w500,
                          align: TextAlign.left)
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
                        child:
                            TextOf(widget.category, 11, blue, FontWeight.w400),
                      ),
                      YMargin(5),
                      Row(
                        children: [
                          widget.id == '001'
                              ? IconOf(
                                  Icons.check_circle_outline_rounded, 20, blue)
                              : InkWell(
                                  child: widget.completedStatus == true
                                      ? IconOf(
                                          Icons.check_circle_outline_rounded,
                                          20,
                                          blue)
                                      : IconOf(Icons.circle_outlined, 20, blue),
                                  onTap: () {
                                    for (int i = 1;
                                        i < ref.read(todoListProvider).length;
                                        i++) {
                                      if ((ref.read(todoListProvider)[i].id ==
                                              widget.id) &&
                                          ref
                                                  .read(todoListProvider)[i]
                                                  .completedStatus ==
                                              false &&
                                          ref
                                                  .read(todoListProvider)[i - 1]
                                                  .completedStatus ==
                                              true) {
                                        setState(() {
                                          widget.completedStatus = true;
                                          ref
                                                  .read(todoListProvider)[i]
                                                  .completedStatus =
                                              widget.completedStatus;
                                        });
                                        setState(() {});
                                        Alerts.success(
                                            "Successfully compled this todo");
                                        setState(() {});
                                        print(
                                            'TODO BEFORE IS ${ref.read(todoListProvider)[i - 1].completedStatus}');
                                        print(
                                            'TODO AFTER IS ${ref.read(todoListProvider)[i].completedStatus}');
                                        setState(() {});
                                      } else if ((ref
                                                  .read(todoListProvider)[i]
                                                  .id ==
                                              widget.id) &&
                                          ref
                                                  .read(todoListProvider)[i]
                                                  .completedStatus ==
                                              false &&
                                          ref
                                                  .read(todoListProvider)[i - 1]
                                                  .completedStatus ==
                                              false) {
                                        Alerts.failed(
                                            "The todo before this isn't completed");
                                      }
                                    }
                                    // if (uncompletedLength > 1) {
                                    //   Alerts.failed(
                                    //       "Can't be completed. ${uncompletedLength - 1} $text of this same category not completed");
                                    // } else {
                                    //   widget.completedStatus =
                                    //       !widget.completedStatus;
                                    //   widget.completedStatus == true
                                    //       ? Alerts.success(
                                    //           "Successfully compled this todo")
                                    //       : Alerts.close();
                                    // }
                                    setState(() {});
                                  },
                                ),
                          widget.id == '001' ? XMargin(10) : XMargin(20),
                          widget.id == '001'
                              ? TextOf('Completed', 12, blue, FontWeight.w400)
                              : InkWell(
                                  child: IconOf(Icons.delete_forever, 20, red),
                                  onTap: () {
                                    setState(() {
                                      ref.read(todoListProvider).removeWhere(
                                          (item) => item.id == widget.id);
                                    });
                                    Navigate.forwardForever(context, Tester());
                                    Navigate.forwardForever(
                                        context, TodoHome());
                                  },
                                ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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
