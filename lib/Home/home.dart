import 'package:flutter/material.dart';

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
            AnimatedContainer(
              duration: const Duration(seconds: 2),
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
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                ],
              ),
            ),
            Container(
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
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                ],
              ),
            ),
          ],
        )
      ],
    ));
    // );
  }
}
