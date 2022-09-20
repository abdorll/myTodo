// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:my_todo/function/navigate.dart';
import 'package:my_todo/screens/todo_home.dart';
import 'package:my_todo/utils/color.dart';
import 'package:my_todo/utils/constants.dart';
import 'package:my_todo/utils/images.dart';
import 'package:my_todo/widgets/botton.dart';
import 'package:my_todo/widgets/spacing.dart';
import 'package:my_todo/widgets/texts.dart';
import 'package:bot_toast/bot_toast.dart';

class IntroScreen extends ConsumerWidget {
  IntroScreen({Key? key}) : super(key: key);
  final currenIndex = StateProvider<int>((ref) => 0);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = PageController();
    void changeIndex(int value) {
      ref.read(currenIndex.notifier).state = value;
    }

    return Scaffold(
        backgroundColor: white,
        body: PageView(
          onPageChanged: changeIndex,
          controller: controller,
          children: [
            IntroPageIntems(
                imagePath: schedule,
                controller: controller,
                currenIndedx: ref.watch(currenIndex),
                title: 'Make schedules',
                subtitle: "Create tasks you'll like to complete"),
            IntroPageIntems(
              imagePath: stayOrganised,
              controller: controller,
              currenIndedx: ref.watch(currenIndex),
              title: 'Stay organised',
              subtitle:
                  'Organise your day with schedules you create to be more productive',
            ),
            IntroPageIntems(
              imagePath: message,
              controller: controller,
              currenIndedx: ref.watch(currenIndex),
              title: 'Chat',
              subtitle:
                  "Create schedules by chatting in the usual way you're used to",
            ),
          ],
        ));
  }
}

class IntroPageIntems extends ConsumerWidget {
  IntroPageIntems(
      {required this.imagePath,
      required this.controller,
      required this.currenIndedx,
      required this.title,
      required this.subtitle,
      Key? key})
      : super(key: key);
  String imagePath, title, subtitle;
  PageController controller;
  int currenIndedx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          YMargin(30),
          Expanded(
              flex: 4,
              child: SizedBox(height: 300, child: Image.asset(imagePath))),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                TextOf(title, 20, black, FontWeight.w800),
                const YMargin(10),
                TextOf(subtitle, 17, black, FontWeight.w300),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myIndicator(0, currenIndedx),
                      XMargin(10),
                      myIndicator(1, currenIndedx),
                      XMargin(10),
                      myIndicator(2, currenIndedx),
                    ],
                  ),
                  YMargin(20),
                  currenIndedx == 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            smallBtn('Get started', white, blue, () async {
                              var userDelais = await Hive.openBox(userBox);
                              userDelais.put(recognisedUserKey, true);
                              BotToast.showCustomLoading(
                                  toastBuilder: (action) {
                                return Center(
                                  child: SizedBox.square(
                                    dimension: 90,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: grey.withOpacity(0.6)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          YMargin(5),
                                          CircularProgressIndicator(
                                            backgroundColor: white,
                                            color: blue,
                                          ),
                                          YMargin(10),
                                          TextOf('Redirecting...', 12, white,
                                              FontWeight.w400),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                              Future.delayed(Duration(seconds: 2), () {
                                BotToast.closeAllLoading();
                                Navigate.forwardForever(context, TodoHome());
                              });
                            })
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            smallBtn('Skip', blue, white, () {
                              controller.animateToPage(2,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeOutCirc);
                            }),
                            smallBtn('Next', white, blue, () {
                              controller.animateToPage(currenIndedx + 1,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeOutCirc);
                            })
                          ],
                        ),
                  YMargin(15)
                ],
              ))
        ],
      ),
    );
  }

  myIndicator(int thisItemIndex, int currentIndex) {
    return SizedBox(
      height: 5,
      width: thisItemIndex == currenIndedx ? 50 : 10,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                thisItemIndex == currenIndedx ? blue : Colors.indigo.shade100),
      ),
    );
  }
}
