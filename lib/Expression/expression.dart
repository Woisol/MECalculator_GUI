import 'package:flutter/material.dart';
import 'package:mecalculator/Components/inputfield_with_default.dart';
import 'package:mecalculator/Data_Process/data_process.dart';

late List<String> expressionSample = [
  // !用const不给后面map，用late又提示不需要……离谱
  "1+1+1+1",
  "-2",
  "88-2*4",
  "2^3+4",
  "8/(9-9)",
  "90-(5-4)*2-2^3",
].map((e) => expressionFormat(e)).toList();

class PageExpression extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String result = "";
  PageExpression({
    required this.controller,
    required this.result,
  });
  // @override
  // State<PageExpression> createState() => _PageExpressionState();
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
              child: InputFieldWithDefault(
                controller: controller,
                result: result,
                options: expressionSample,
              ),
              // Stack(
              //   children: [
              //     Expanded(child: child)
              //     TextField(),
              //     // !定位问题……这个Incorrect use of ParentDataWidget.的报错就来自这个Position……(看调试控制台啊你……)
              //     // !咳咳也是……忘记了Position只能放在Stack里面……
              //     // Positioned(
              //     //   child: IconButton(
              //     //       onPressed: () {},
              //     //       icon: Icon(Icons.arrow_back_ios, size: 20)),
              //     //   right: 20,
              //     // )
              //   ],
              // ),
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
// td Incorrect use of ParentDataWidget.，另一个Multinomial没问题看看这里……不对另一个跳转多了也会崩……

// class _PageExpressionState extends State<PageExpression> {
// }
