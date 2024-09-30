import 'package:flutter/material.dart';

class PageExpression extends StatefulWidget {
  @override
  State<PageExpression> createState() => _PageExpressionState();
}
// td Incorrect use of ParentDataWidget.，另一个Multinomial没问题看看这里……不对另一个跳转多了也会崩……

class _PageExpressionState extends State<PageExpression> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          children: [
            Align(
              // Expanded(不能用……没用不说甚至会炸……
              alignment: Alignment.centerLeft,
              child: Text("表达式：",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start),
            ),
            Container(
              // color: Colors.grey[400],
              // !艹服了这个为什么要限制……不能同时有color和decoration……
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[500]!,
                        offset: Offset(0, 2),
                        blurRadius: 5)
                  ]),
              child: Row(
                children: [
                  InputChip(label: const Text("表达式")),
                  Positioned(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios, size: 20)),
                    right: 20,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            )
          ],
        ));
  }
}
