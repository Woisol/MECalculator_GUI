import 'package:flutter/material.dart';
import 'package:mecalculator/Home/home.dart';
import 'package:mecalculator/Home/title_bar.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      // !这里又提示加const提高性能了……
      size: Size(600, 400),
      center: true,
      backgroundColor: Colors.transparent,
      // skipTaskbar: true,
      titleBarStyle: TitleBarStyle.hidden,
      title: "MECalculator");

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    // !？？？为什么参数一定要有个_……
    await windowManager.show();
    await windowManager.focus();
  });
  // !使用window_manager必须加上

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to MECalculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow[600]!),
        useMaterial3: true,
      ),
      home: Material(child: Column(children: [const TitleBar(), Home()])),
      // !原意在于不用scaffold时Text默认会有双簧下划线，查了教程发现根节点设置成Material也可以解决
      // !然后发现默认透明的背景也变回来了……
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return
//         // Scaffold(
//         //   appBar: AppBar(),
//         //   body: const Center(
//         //     child: Column(
//         //       mainAxisAlignment: MainAxisAlignment.center,
//         //       children: <Widget>[
//         //         Text(
//         //           'You have pushed the button this many times:',
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // );
//         ;
//   }
// }
