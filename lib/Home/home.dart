import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
import 'package:animations/animations.dart';
import 'package:mecalculator/Expression/expression.dart';
import 'package:mecalculator/Multinomial/multinomial.dart';
import 'package:mecalculator/main.dart';

class Home extends StatelessWidget {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  String result = "";
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child:
            //  ConstrainedBox(
            //     constraints: BoxConstraints(minHeight: double.infinity),
            //     child:
            // !据说在Column和Row下才能使用Expanded，其它地方就会报错Incorrect use of ParentDataWidget.
            // !但是你这里上级也是Column啊……
            // !不过WidgetTree也看到中间隔着这个Home……是这个问题吗……
            // !不管了崩就崩吧……现在本来就一堆解决不了Expande就Expande不然这调不了居中……
            // Align(

            // alignment: Alignment.center,
            // Center(
            //     heightFactor: 2,
            // !这个是会超的……
            // child:
            // heightFactor: double.infinity,
            // !啊不行吗……
            // !这个Center下再跌Row或Column就没用了……
            Column(
          // !是不是嵌套的Column无法MainAxisSize.max？必须用Expand？
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
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
                          // !未嵌套的Column默认就是max不用设了
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                      );
                    },
                    openBuilder: (BuildContext context, VoidCallback _) {
                      return PageContent(
                        title: "一元稀疏多项式",
                        child: PageMultinomial(),
                        // back: true,
                      );
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                      );
                    },
                    openBuilder: (BuildContext context, VoidCallback _) {
                      return PageContent(
                        title: "表达式求值",
                        child: PageExpression(
                          controller: _controller1,
                          result: result,
                        ),
                        // back: true,
                      );
                    }),
              ],
            )
          ],
          // )
        ));
  }
}
