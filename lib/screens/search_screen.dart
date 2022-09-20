import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/model/todos_list.dart';
import 'package:my_todo/screens/todo_home.dart';
import 'package:my_todo/utils/color.dart';
import 'package:my_todo/utils/images.dart';
import 'package:my_todo/widgets/each_todo.dart';
import 'package:my_todo/widgets/spacing.dart';
import 'package:my_todo/widgets/texts.dart';

StateProvider<List<TodoList>> searchProvider = StateProvider((_) => []);

class SearchSreen extends ConsumerStatefulWidget {
  const SearchSreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchSreenState();
}

class _SearchSreenState extends ConsumerState<SearchSreen> {
  @override
  void initState() {
    ref.read(searchProvider.notifier).state = ref.read(todoListProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<EachTodo> eachTodoItem =
        List.generate(ref.watch(searchProvider).length, (index) {
      TodoList todo = ref.watch(searchProvider)[index];
      return EachTodo(
        id: todo.id!,
        title: todo.title ?? '',
        description: todo.description ?? '',
        category: todo.category ?? '',
        completedStatus: todo.completedStatus,
      );
    });
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(color: blue),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const YMargin(40),
                  Row(
                    children: [
                      TextOf('Seach Todo', 30, white, FontWeight.w600)
                    ],
                  ),
                  searchBox(),
                  const YMargin(10)
                ],
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: eachTodoItem.length == 0
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          searchResult,
                          height: 200,
                        ),
                        YMargin(20),
                        TextOf('Nothing match your search', 15, black,
                            FontWeight.w500)
                      ],
                    ))
                  : Column(
                      children: eachTodoItem,
                    ))
        ],
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<TodoList> results = [];
    if (enteredKeyword.isEmpty) {
      results = ref.read(todoListProvider);
    } else {
      results = ref
          .read(todoListProvider)
          .where((item) =>
              item.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    ref.read(searchProvider.notifier).state = results;
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }
}
