import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:my_todo/screens/intro_screen.dart';
import 'package:my_todo/screens/todo_home.dart';
import 'package:my_todo/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Widget? homeScreen;
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  await Hive.openBox(userBox);
  var openBox = await Hive.openBox(userBox);
  openBox.get(recognisedUserKey) == true
      ? homeScreen = TodoHome()
      : homeScreen = IntroScreen();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyTodo',
        home: homeScreen,
        builder: (context, child) {
          return botToastBuilder(context, child);
        },
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
      ),
    );
  }
}
