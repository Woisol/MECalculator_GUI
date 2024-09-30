import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
import 'package:animations/animations.dart';
import 'package:mecalculator/main.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        // child: Center(
        // !这个Center下再跌Row或Column就没用了……
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // padding: Padding(padding: ),
          // padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.only(bottom: 20),
          // color: ,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [Colors.yellow[600]!, Colors.yellow[300]!]),
              boxShadow: [
                // !az本想想换成elevation的但是没有()
                BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 5))
              ]),

          child: const Text("请选择功能",
              style: TextStyle(fontSize: 24, color: Colors.black)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // !没有gap……
          children: [
            // !参考 https://blog.csdn.net/weixin_41897680/article/details/131851699#:~:text=%E6%96%87%E7%AB%A0%E6%B5%8F%E8%A7%88%E9%98%85%E8%AF%BB2.4k
            OpenContainer(
                // closedColor: Colors.transparent,
                // closedColor: Colors.white.withAlpha(0),
                // !这两个都不知道为什么会有黑色的背景……
                // closedColor: Colors.white,
                closedElevation: 0,
                // closedShape: ,
                // !但是似乎依然无法设置padding……
                // !，！！！用这个解决了！！！原来这里的背景阴影和阴影使用elevation设置的……
                closedBuilder: (BuildContext context, VoidCallback _) {
                  return Container(
                    alignment: Alignment.center,
                    //
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          // "assets/function.svg",
                          // !人傻了默认不支持svg要么就加个flutter-svg
                          // ~~甚至导致flutter卡死必须重启……噢噢是断点了……
                          "assets/function.png",
                          width: 64,
                          height: 64,
                        ),
                        const Text("一元稀疏多项式",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  );
                },
                openBuilder: (BuildContext context, VoidCallback _) {
                  return PageContent(
                      title: "一元稀疏多项式", child: Center(child: Text("一元稀疏多项式")));
                }),
            OpenContainer(
                // closedColor: Colors.transparent,
                // closedColor: Colors.white.withAlpha(0),
                // !这两个都不知道为什么会有黑色的背景……
                // closedColor: Colors.white,
                closedElevation: 0,
                // closedShape: ,
                // !但是似乎依然无法设置padding……
                // !，！！！用这个解决了！！！原来这里的背景阴影和阴影使用elevation设置的……
                closedBuilder: (BuildContext context, VoidCallback _) {
                  return Container(
                    alignment: Alignment.center,
                    //
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          // "assets/function.svg",
                          // !人傻了默认不支持svg要么就加个flutter-svg
                          // ~~甚至导致flutter卡死必须重启……噢噢是断点了……
                          "assets/expression.png",
                          width: 64,
                          height: 64,
                        ),
                        const Text("表达式求值",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  );
                },
                openBuilder: (BuildContext context, VoidCallback _) {
                  return PageContent(
                      title: "表达式求值", child: Center(child: Text("表达式求值")));
                }),
          ],
        )
      ],
    ));
    // );
  }
}
