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
    // return <Widget>[
    // return Container(
    //     child: Column(children: [
    // !Incorrect use of ParentDataWidget
    // !但是Routes又只能在MaterialApp里面用……
    // const TitleBar(),
    return MaterialApp(
        title: 'Welcome to MECalculator',
        theme: ThemeData(
          useMaterial3: true,
        ),
        // routes: {
        //   "/": (context) => PageContent(Home()),
        //   // "/Multinomials":context => Page(Home()),
        //   // !flutter不能省略()
        //   "/Multinomials": (context) => PageContent(Home()),
        // },
        home: PageContent(title: "ME Calculator", child: Home())
        // !6……
        // !https://www.jianshu.com/p/c5282f34670f这里的 实战 就是直接每个页面都搞一个TitleBar了……行吧……
        // home: Scaffold(
        //   // appBar: AppBar()
        //   // appBar: Container(),
        // ),
        // !原意在于不用scaffold时Text默认会有双簧下划线，查了教程发现根节点设置成Material也可以解决
        // !然后发现默认透明的背景也变回来了……
        );
    // ]));
  }
}

// !好像引入了Animations.dart就重复了……
class PageContent extends StatelessWidget {
  // !注意这里运行时直接修改类名导致无法重载，class null没有''的构造函数()
  // bool back = false;
  String title;
  Widget child;
  PageContent({
    required Widget this.child,
    required String this.title,
  });
  // this.back = false
  // PageContent(this.child, this.title);
  // PageContent(this.child,required this.title);
  // td 不懂怎么加key解决警告……
  @override
  Widget build(BuildContext context) {
    // !Container(
    // !报错
    return Material(
        // !这个Material移到Home那里OpenContainer就没有透明度变化了……
        color: Colors.white,
        // color: Colors.transparent,
        child: Column(children: [TitleBar(title: title), child]));
    // !Const class cannot become non-const: Library:'package:mecalculator/Home/title_bar.dart' Class: TitleBar.Try performing a hot restart instead.
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
//     return MaterialPageRoute(builder: builder)
//   }
// }
