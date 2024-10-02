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
// List<Map<String, String>> expressionSample2 = [{},{}];
// List<String[2]> expressionSample2 = [
//   {"7", "7"},
//   {"8", "8"},
//   {"9", "9"},
//   {}
// ];
List<List<String>> calKeyBoardButtonList = [
  ["7", "7"],
  ["8", "8"],
  ["9", "9"],
  [".", "."],
  ["+", "+"],
  ["-", "-"],
  ["^", "^"],
  ["4", "4"],
  ["5", "5"],
  ["6", "6"],
  ["1", "1"],
  ["2", "2"],
  ["3", "3"],
  ["0", "0"],
  ["*", "*"],
  ["/", "/"],
  ["=", "="]
];

// !并不支持这样的定义……
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
    return Expanded(
        child: Container(
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
          SizedBox(
            width: double.infinity,
            height: 20,
          ),
          DecoratedBox(
            // color: Colors.grey[400],
            // !艹服了这个为什么要限制……不能同时有color和decoration……
            // margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),

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
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          //   decoration: BoxDecoration(
          //       // color: Colors.white,
          //       borderRadius: BorderRadius.all(Radius.circular(10))),
          // ),
          // Expanded(
          //     // child: Container(
          //     // width: double.infinity,
          //     // height: double.infinity,
          //     child: GridView.builder(
          //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 7,
          //             // childAspectRatio: 1.5,
          //             crossAxisSpacing: 6,
          //             mainAxisSpacing: 10),
          //         children: <Widget>[
          //       OutlinedButton(onPressed: () {}, child: const Text("7")),
          //       OutlinedButton(onPressed: () {}, child: const Text("8")),
          //       OutlinedButton(onPressed: () {}, child: const Text("9")),
          //     ]
          //         // calKeyBoardButtonList
          //         //     .map((key) => calKeyBoardButton(key[0], key[1]))
          //         //     .toList(),
          //         // [
          //         //   OutlinedButton(
          //         //       onPressed: () {
          //         //         controller.clear();
          //         //         result = "";
          //         //       },
          //         //       child: Text("清空")),
          //         // ],
          //         // ),
          //         ))
          // ConstrainedBox(
          //     constraints: BoxConstraints(
          //         minWidth: double.infinity, minHeight: double.infinity),
          //     child: Wrap(
          //       direction: Axis.vertical,
          //       spacing: 4,
          //       children: calKeyBoardButtonList
          //           .map((data) => calKeyBoardButton(data[0], data[1]))
          //           .toList(),
          //     ))
          // GridView(
          //   gridDelegate:
          //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          //   children: calKeyBoardButtonList
          //       .map((data) => calKeyBoardButton(data[0], data[1]))
          //       .toList(),
          // )
          // !死活用不了Grid……算了原始方法手写flex吧(bushi)
          SizedBox(
            width: double.infinity,
            height: 20,
          ),

          Expanded(
              child: Row(
            // !谁能告诉我为什么这里一定要加个Expanded不然甚至是崩溃？？？排除了巨久……………………………在外面加了SizeBox都解决不了都怀疑是不是MaterialAppmd没带最大高度限制真的服了flutter怎么这么难用md……
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  calKeyBoardButton("7"),
                  calKeyBoardButton("4"),
                  calKeyBoardButton("1"),
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // !艹虽然不能设置size但是这个居然也可以……
                children: [
                  calKeyBoardButton("8"),
                  calKeyBoardButton("5"),
                  calKeyBoardButton("2"),
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  calKeyBoardButton("9"),
                  calKeyBoardButton("6"),
                  calKeyBoardButton("3"),
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  calKeyBoardButton("."),
                  calKeyBoardButton("0", flex: 2),
                ],
              )),
              SizedBox(
                width: 25,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // !艹虽然不能设置size但是这个居然也可以……
                children: [
                  calKeyBoardButton("+"),
                  calKeyBoardButton("×", pressValue: "*"),
                  calKeyBoardButton("("),
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  calKeyBoardButton("-"),
                  calKeyBoardButton("÷", pressValue: "/"),
                  calKeyBoardButton(")"),
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  calKeyBoardButton("^"),
                  calKeyBoardButton("←", pressValue: "\b"),
                  calKeyBoardButton("=", color: Colors.yellow[700]),
                ],
              )),
            ],
          )),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
                "输入预览：.\\Cpp\\calculator.exe -E \"" + controller.text + "\"",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.end),
          )
        ],
      ),
    ));
  }

  Widget calKeyBoardButton(String text,
      {String? pressValue, int? flex, Color? color, Function()? onPressed}) {
    // !正确的可选参数的写法……
    // ;)组件化也不一定要class嘛
    return Expanded(
      //  ConstrainedBox(
      //   constraints:
      //       BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
      //       // !md不能乱用的……
      flex: flex ?? 1,
      child: OutlinedButton(
        style: ButtonStyle(
          // !？？？这里函数化组件必须用这个WidgetStatePropertyAll来提供参数？？
          backgroundColor: WidgetStatePropertyAll(color ?? Colors.white),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )),
        ),
        child: Text(text, textScaler: TextScaler.linear(2)),
        onPressed: onPressed ??
            () {
              if (pressValue == "\b" && controller.text.length > 0)
                controller.text =
                    controller.text.substring(0, controller.text.length - 1);
              else
                controller.text += pressValue ?? text;
              // controller.
            },
      ),
    );
  }
}
// td Incorrect use of ParentDataWidget.，另一个Multinomial没问题看看这里……不对另一个跳转多了也会崩……

// class _PageExpressionState extends State<PageExpression> {
// }
// !az不能嵌套class……
// class CalKeyBoardButton extends StatelessWidget {
//   late String text;
//   late String? pressValue;
//   // late Function()? onButtonPressed;
// // late type
// CalKeyBoardButton({required this.text, this.pressValue});
// @override
// Widget build(BuildContext context) {
//   return ElevatedButton(onPressed: , child: child)
// }
