import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/function/navigate.dart';
import 'package:my_todo/model/todo_categories.dart';
import 'package:my_todo/model/todos_list.dart';
import 'package:my_todo/screens/todo_home.dart';
import 'package:my_todo/utils/color.dart';
import 'package:my_todo/utils/images.dart';
import 'package:my_todo/widgets/iconss.dart';
import 'package:my_todo/widgets/input_field.dart';
import 'package:my_todo/widgets/spacing.dart';
import 'package:my_todo/widgets/texts.dart';

var allFieldsCompleted = StateProvider((_) => false);
var selectedTodo = StateProvider<int>((_) => -1);
var fresh = StateProvider<int>((_) => -1);
var saveProvider = StateProvider((_) => false);
var doneClicked = StateProvider((_) => false);
var completdStat = StateProvider((_) => false);

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AddTodoScreenState();
}

class AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  @override
  void initState() {
    textController = TextEditingController();
    todoInput.length == 1
        ? todoInput.add(buildMessage(
            todoResponse(TextOf(todoMessages[0], 15, black, FontWeight.w400))))
        : null;
    super.initState();
  }

  TextEditingController? textController;

  bool sendEnabled() {
    return todoInput.length % 2 == 0 ? true : false;
  }

  String? inputedString;
  String get _inputtedString => inputedString ?? '';
  static String? title;
  static String? description;
  static String? todoCategory;
  static List<String> todoMessages = [
    "What's your todo title?",
    'Give a decription'
  ];

  static List<TodoCategories> categories = [
    TodoCategories(category: '🏪 Shop', id: 0),
    TodoCategories(category: '🏂 Sport', id: 1),
    TodoCategories(category: '🤝 Visit', id: 2),
    TodoCategories(category: '📚 Study', id: 3),
    TodoCategories(category: '🤸‍♂ Gym', id: 4),
    TodoCategories(category: '🍔 Eat', id: 5),
    TodoCategories(category: '📸 Stream', id: 6),
    TodoCategories(category: '🙇 Meditate', id: 7),
    TodoCategories(category: '📲 Call', id: 8),
    TodoCategories(category: '👩‍🏭 Chore', id: 9),
    TodoCategories(category: '🛣 Travel', id: 10),
    TodoCategories(category: '🥱 Sleep', id: 11),
    TodoCategories(category: '👨‍💻 Code', id: 12),
    TodoCategories(category: '👏 Pray', id: 13),
    TodoCategories(category: '👨‍🍳 Cook', id: 14),
    TodoCategories(category: '🥰 Social', id: 15),
  ];
  bool buttonEnabled() {
    return _inputtedString != '' ? true : false;
  }

  static List<Widget> todoInput = [const YMargin(10)];
  static Future<Widget> futureMessage(value) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return value;
    });
  }

  static buildMessage(Widget message) {
    return FutureBuilder(
        future: futureMessage(message),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return message;
          } else {
            return builtTyping();
          }
        });
  }

  static Widget todoResponse(Widget message) {
    return Row(
      children: [
        Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: message),
            const YMargin(10),
          ],
        ),
      ],
    );
  }

  static Row builtTyping() {
    return Row(
      children: [
        SizedBox(
            height: 40,
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  image: const DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(typing))),
            ))
      ],
    );
  }

  List<Widget> allCategories = List.generate(categories.length, (index) {
    TodoCategories singleCategory = categories[index];
    return Consumer(builder: (context, ref, child) {
      FocusScope.of(context).unfocus();
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ref.watch(allFieldsCompleted.notifier).state = true);
      return InkWell(
        onTap: (title != null && description != null && todoCategory != null)
            ? () {}
            : () {
                todoCategory = singleCategory.category;
                ref.watch(selectedTodo.notifier).state = singleCategory.id!;
                Navigator.pop(context);
                Navigate.forwardForever(context, const AddTodoScreen());
                String itemCat = categories
                    .where((text) => text.id == ref.watch(selectedTodo))
                    .toList()[0]
                    .category!;
                todoInput.add(userInput(
                    'Selected category: ${itemCat.toUpperCase()}', context));
                ref.watch(saveProvider.notifier).state = true;
                todoInput.add(buildMessage(Column(children: [
                  todoResponse(
                      TextOf("You're all set", 15, black, FontWeight.w400)),
                  todoResponse(TextOf(
                      "Click 'Done' to save and 'Restart' to start all over",
                      15,
                      black,
                      FontWeight.w400)),
                  YMargin(70)
                ])));
                todoInput.add(Container());
              },
        child: category(singleCategory),
      );
    });
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(todoBackground), fit: BoxFit.cover)),
        ),
        Scaffold(
          appBar: AppBar(
            title: TextOf('Add Todo', 25, white, FontWeight.w700),
            backgroundColor: blue,
            toolbarHeight: 60,
            leadingWidth: 85,
            leading: Row(
              children: [
                const XMargin(10),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: IconOf(Icons.arrow_back_ios_new_rounded, 20, white)),
                const XMargin(10),
                CircleAvatar(
                  backgroundImage: AssetImage(logo),
                )
              ],
            ),
          ),
          body: Stack(
            children: [
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: todoInput,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  child: ref.read(allFieldsCompleted) == true
                      ? SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            child: Center(
                              child: ref.watch(saveProvider) == true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              ref
                                                  .watch(doneClicked.notifier)
                                                  .state = true;
                                              ref
                                                  .watch(
                                                      todoListProvider.notifier)
                                                  .state
                                                  .add(TodoList(
                                                      id: DateTime.now()
                                                          .millisecondsSinceEpoch
                                                          .toString(),
                                                      title: title,
                                                      description: description,
                                                      category: categories
                                                          .where((text) =>
                                                              text.id ==
                                                              ref.watch(
                                                                  selectedTodo))
                                                          .toList()[0]
                                                          .category!,
                                                      completedStatus: false));
                                              Navigate.forwardForever(
                                                  context, TodoHome());

                                              ref
                                                  .read(allFieldsCompleted
                                                      .notifier)
                                                  .state = false;
                                              ref
                                                  .read(saveProvider.notifier)
                                                  .state = false;
                                              todoInput.clear();
                                              todoInput.add(const YMargin(10));
                                              title = null;
                                              description = null;
                                              todoCategory = null;
                                              ref
                                                  .watch(selectedTodo.notifier)
                                                  .state = ref.watch(fresh);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: TextOf('Done', 13, blue,
                                                  FontWeight.w400),
                                            )),
                                        const XMargin(50),
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigate.forwardForever(context,
                                                  const AddTodoScreen());

                                              ref
                                                  .read(allFieldsCompleted
                                                      .notifier)
                                                  .state = false;
                                              ref
                                                  .read(saveProvider.notifier)
                                                  .state = false;
                                              todoInput.clear();
                                              todoInput.add(const YMargin(10));
                                              title = null;
                                              description = null;
                                              todoCategory = null;
                                              ref
                                                  .watch(selectedTodo.notifier)
                                                  .state = ref.watch(fresh);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: TextOf('Restart', 13, blue,
                                                  FontWeight.w400),
                                            ))
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextOf('Almost done but you', 16, white,
                                            FontWeight.w400),
                                        XMargin(10),
                                        InkWell(
                                          onTap: () {
                                            Navigate.forwardForever(
                                                context, TodoHome());
                                            todoInput.clear();
                                            todoInput.add(const YMargin(10));
                                            title = null;
                                            description = null;
                                            todoCategory = null;
                                            ref
                                                .watch(selectedTodo.notifier)
                                                .state = ref.watch(fresh);
                                            ref
                                                .read(saveProvider.notifier)
                                                .state = false;

                                            ref
                                                .read(
                                                    allFieldsCompleted.notifier)
                                                .state = false;
                                            setState(() {});
                                          },
                                          child: TextOf(
                                            'can restart',
                                            16,
                                            white,
                                            FontWeight.w400,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        )
                      : Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(children: [
                            Expanded(
                                flex: 8,
                                child: InputField(
                                    textController: textController!,
                                    icon: Icons.add,
                                    onChanged: (e) {
                                      setState(() {});
                                      inputedString = e!;
                                      setState(() {});
                                    })),
                            const XMargin(2),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: buttonEnabled() == true
                                    ? () {
                                        textController!.clear();
                                        setState(() {
                                          ((title == null) &
                                                  (description == null))
                                              ? title = inputedString
                                              : ((title != null) &
                                                      (description == null))
                                                  ? description = inputedString
                                                  : null;
                                        });
                                        todoInput.add(userInput(
                                            ((title != null) &&
                                                    (description == null)
                                                ? title!
                                                : (title != null) &&
                                                        (description != null)
                                                    ? description!
                                                    : ''),
                                            context));

                                        todoInput
                                            .add(
                                                (title != null &&
                                                        description != null)
                                                    ? Row(
                                                        children: [
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.8,
                                                              child: Column(
                                                                  children: [
                                                                    const YMargin(
                                                                        10),
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              white,
                                                                          borderRadius: const BorderRadius.only(
                                                                              topRight: Radius.circular(20),
                                                                              bottomRight: Radius.circular(20),
                                                                              bottomLeft: Radius.circular(20))),
                                                                      child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                TextOf('Select todo category', 15, black, FontWeight.w400),
                                                                              ],
                                                                            ),
                                                                            const YMargin(10),
                                                                            Wrap(
                                                                              runSpacing: 10,
                                                                              spacing: 10,
                                                                              children: allCategories,
                                                                            )
                                                                          ]),
                                                                    ),
                                                                  ])),
                                                        ],
                                                      )
                                                    : buildMessage(todoResponse(
                                                        TextOf(
                                                            description == null
                                                                ? todoMessages[
                                                                    1]
                                                                : title!,
                                                            15,
                                                            black,
                                                            FontWeight.w400))));

                                        setState(() {
                                          inputedString = '';
                                        });
                                      }
                                    : () {},
                                child: CircleAvatar(
                                  backgroundColor: buttonEnabled() == true
                                      ? blue
                                      : blue.withOpacity(0.6),
                                  child: IconOf(Icons.send, 20, white),
                                ),
                              ),
                            )
                          ]),
                        ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
        )
      ],
    );
  }

  static Container todoOption(String option) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration:
          BoxDecoration(color: blue2, borderRadius: BorderRadius.circular(30)),
      child: TextOf(option, 13, black, FontWeight.w400),
    );
  }

  static Row userInput(String text, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          child: Column(
            children: [
              const YMargin(10),
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: TextOf(text, 15, white, FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }

  static category(TodoCategories singleCategory) {
    return Consumer(builder: (context, ref, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: ref.read(selectedTodo) == singleCategory.id ? blue : blue2,
            borderRadius: BorderRadius.circular(30)),
        child: TextOf(
            singleCategory.category!,
            13,
            ref.read(selectedTodo) == singleCategory.id! ? white : black,
            FontWeight.w400),
      );
    });
  }
}
