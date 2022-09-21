// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/function/navigate.dart';
import 'package:my_todo/model/todos_list.dart';
import 'package:my_todo/screens/add_todo.dart';
import 'package:my_todo/screens/search_screen.dart';
import 'package:my_todo/utils/color.dart';
import 'package:my_todo/utils/images.dart';
import 'package:my_todo/widgets/each_todo.dart';
import 'package:my_todo/widgets/iconss.dart';
import 'package:my_todo/widgets/spacing.dart';
import 'package:my_todo/widgets/texts.dart';

StateProvider<List<TodoList>> todoListProvider = StateProvider((_) => [
      TodoList(
          id: '001',
          title: 'Check MyTodo',
          description: 'View my daily schedules',
          category: '🥰 Social',
          completedStatus: false)
    ]);

class TodoHome extends ConsumerStatefulWidget {
  TodoHome({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoHomeState();
}

class _TodoHomeState extends ConsumerState<TodoHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<EachTodo> eachTodoItem =
        List.generate(ref.watch(todoListProvider).length, (index) {
      TodoList todo = ref.watch(todoListProvider)[index];
      return EachTodo(
        id: todo.id!,
        title: todo.title ?? '',
        description: todo.description ?? '',
        category: todo.category ?? '',
        completedStatus: todo.completedStatus,
      );
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: blue,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  YMargin(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MyTodo',
                          style: GoogleFonts.pacifico(
                              color: white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600)),
                      InkWell(
                        child: ImageIcon(
                          AssetImage(
                            search,
                          ),
                          color: white,
                          size: 25,
                        ),
                        onTap: () {
                          Navigate.forward(context, SearchSreen());
                        },
                      ),
                    ],
                  ),
                  YMargin(10),
                  Row(
                    children: [
                      TextOf('Make schedules • Stay organised', 15, ash,
                          FontWeight.w600),
                    ],
                  ),
                  YMargin(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: TabBar(
                            indicatorWeight: 2,
                            labelColor: blue,
                            controller: _tabController,
                            indicatorPadding: EdgeInsets.all(10),
                            unselectedLabelColor: white,
                            labelStyle: GoogleFonts.combo(
                                fontSize: 12, fontWeight: FontWeight.w700),
                            unselectedLabelStyle: GoogleFonts.combo(
                                fontSize: 12, fontWeight: FontWeight.w700),
                            indicator: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(20)),
                            tabs: [
                              Tab(
                                text: 'All',
                              ),
                              Tab(
                                text: 'Completed',
                              )
                            ]),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            YMargin(10),
            Expanded(
                child: TabBarView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: eachTodoItem.length == 0
                      ? Center(
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              busy1,
                              height: 200,
                            ),
                            YMargin(20),
                            TextOf(
                                'No todo available. Click the add icon to create',
                                15,
                                black,
                                FontWeight.w500)
                          ],
                        ))
                      : SingleChildScrollView(
                          child: Column(
                            children: eachTodoItem,
                          ),
                        ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: CompletedTab(eachTodoItem: eachTodoItem),
                )
              ],
              controller: _tabController,
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: blue,
            child: IconOf(Icons.add_rounded, 40, white),
            onPressed: () {
              Navigate.forward(context, AddTodoScreen());
            }),
      ),
    );
  }
}

class CompletedTab extends StatefulWidget {
  CompletedTab({
    Key? key,
    required this.eachTodoItem,
  }) : super(key: key);

  List<EachTodo> eachTodoItem;

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  List<Widget>? completedList;
  @override
  void initState() {
    completedList = widget.eachTodoItem
        .where((element) => element.completedStatus == true)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return completedList!.length == 0
        ? Center(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                busy2,
                height: 200,
              ),
              YMargin(20),
              TextOf(
                  'No todo is completed.\nClick the circuler icon below a todo to complete',
                  15,
                  black,
                  FontWeight.w500)
            ],
          ))
        : SingleChildScrollView(
            child: Column(
              children: completedList!,
            ),
          );
  }
}
