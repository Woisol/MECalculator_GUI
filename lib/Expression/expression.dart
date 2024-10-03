import 'package:flutter/material.dart';
import 'package:mecalculator/Components/input_preview.dart';
import 'package:mecalculator/Data_Process/data_process.dart';
import 'package:mecalculator/main.dart';

late List<String> expressionSample = [
  // !用const不给后面map，用late又提示不需要……离谱
  "1+1+1+1",
  "-2",
  "88-2*4",
  "2^3+4",
  "8/(9-9)",
  "90-(5-4)*2-2^3",
].map((e) => expressionFormatToShow(e)).toList();
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
class PageExpression extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  // PageExpression({
  //   required this.controller,
  //   // required this.result,
  // });
  @override
  State<PageExpression> createState() => _PageExpressionState();
}
// td Incorrect use of ParentDataWidget.，另一个Multinomial没问题看看这里……不对另一个跳转多了也会崩……

class _PageExpressionState extends State<PageExpression> {
  String input = "";
  String result = "";
  void handleGetRes() {
    setState(() {
      result = getCalRes(["-E", expressionFormatToConsole(input)]);
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      setState(() {
        input = widget.controller.text;
        result = '';
      });
    });
    return Expanded(
        child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              // if (event is KeyEvent) {
              // if(event.logicalKey.keyLabel == "Enter"){

              // }
              switch (event.logicalKey.keyLabel) {
                // case "0":
                //   widget.controller.text = widget.controller.text + "0";
                //   break;
                // case "1":
                //   widget.controller.text = widget.controller.text + "1";
                //   break;
                // case "2":
                //   widget.controller.text = widget.controller.text + "2";
                //   break;
                // case "3":
                //   widget.controller.text = widget.controller.text + "3";
                //   break;
                // case "4":
                //   widget.controller.text = widget.controller.text + "4";
                //   break;
                // case "5":
                //   widget.controller.text = widget.controller.text + "5";
                //   break;
                // case "6":
                //   widget.controller.text = widget.controller.text + "6";
                //   break;
                // case "7":
                //   widget.controller.text = widget.controller.text + "7";
                //   break;
                // case "8":
                //   widget.controller.text = widget.controller.text + "8";
                //   break;
                // case "9":
                //   widget.controller.text = widget.controller.text + "9";
                //   break;
                // case ".":
                //   widget.controller.text = widget.controller.text + ".";
                //   break;
                // case "+":
                //   widget.controller.text = widget.controller.text + "+";
                //   break;
                // case "-":
                //   widget.controller.text = widget.controller.text + "-";
                //   break;
                // case "*":
                //   widget.controller.text = widget.controller.text + "*";
                //   break;
                // case "/":
                //   widget.controller.text = widget.controller.text + "/";
                //   break;
                // case "^":
                //   widget.controller.text = widget.controller.text + "^";
                //   break;
                case "=":
                case "Enter":
                  handleGetRes();
                  break;
                // case "Backspace":
                //   widget.controller.text = widget.controller.text
                //       .substring(0, widget.controller.text.length - 1);
                //   break;
                default:
                  break;
                // if (event.logicalKey.keyLabel == "Enter") {
                //   handleGetRes();
                // }
              }
              // }
            },
            child: Center(
                // !不加这个Center下面的ConstrainedBox就是不生效……不过本来也该加来居中……
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 1400, maxHeight: 800),
                    // !md这个maxHeight不生效……
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      child: Column(
                        children: [
                          Align(
                            // Expanded(不能用……没用不说甚至会炸……
                            alignment: Alignment.centerLeft,
                            child: Text("表达式：",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[500]!,
                                      offset: Offset(0, 2),
                                      blurRadius: 5)
                                ]),
                            child: InputFieldWithDefault(
                              controller: widget.controller,
                              result: result,
                              options: expressionSample,
                              handleGetRes: handleGetRes,
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

                          // ConstrainedBox(constraints: BoxConstraints(maxHeight: 800),child: ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Text(
                          //       "输入预览：.\\Cpp\\calculator.exe -E \"" + input + "\"",
                          //       style: TextStyle(fontSize: 20),
                          //       textAlign: TextAlign.end),
                          // )
                          CalKeyBoardButton(
                              controller: widget.controller,
                              handleGetRes: handleGetRes),
                          InputPreview([
                            "-E",
                            "\"" + expressionFormatToConsole(input) + "\""
                          ])
                        ],
                      ),
                    )))));
  }
}

class CalKeyBoardButton extends StatelessWidget {
  late TextEditingController controller;
  late dynamic handleGetRes;
  CalKeyBoardButton({required this.controller, required this.handleGetRes});
  Widget calKeyBoardButton(String text,
      {int? flex, Color? color, Function()? onPressed, bool? enabled}) {
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
              controller.text += text;
              // controller.
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // td 考虑用GridView优化一下……
    return Expanded(
        child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              // !谁能告诉我为什么这里一定要加个Expanded不然甚至是崩溃？？？排除了巨久……………………………在外面加了SizeBox都解决不了都怀疑是不是MaterialAppmd没带最大高度限制真的服了flutter怎么这么难用md……
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  // !哭了就是去不了这个Expand……不然就报错没有大小……
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      calKeyBoardButton("7"),
                      calKeyBoardButton("4"),
                      calKeyBoardButton("1"),
                    ],
                  ),
                ),
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
                    // calKeyBoardButton(".", onPressed: () {
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) => Dialog(
                    //           child: Container(
                    //               padding:
                    //                   EdgeInsets.all(20),
                    //               child: Text(
                    //                   "暂不支持小数点输入，别问问就是不放这个按钮这里就会很空"))));
                    // }),
                    calKeyBoardButton("C", onPressed: () {
                      controller.text = "";
                    }),
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
                    calKeyBoardButton("×"),
                    calKeyBoardButton("("),
                  ],
                )),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    calKeyBoardButton("-"),
                    calKeyBoardButton("÷"),
                    calKeyBoardButton(")"),
                  ],
                )),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    calKeyBoardButton("^"),
                    calKeyBoardButton("←", color: Colors.grey[300],
                        onPressed: () {
                      if (controller.text.length > 0)
                      // if (widget
                      //         .controller.selection.baseOffset ==
                      //     controller.selection.extentOffset)
                      {
                        controller.text = controller.text
                            .substring(0, controller.text.length - 1);
                        // } else {
                        //   widget.controller.text = widget.controller.text.replaceAll(
                        //       widget.controller.text.substring(
                        //           widget.controller.selection.baseOffset <
                        //                   widget.controller.selection.extentOffset
                        //               ? widget.controller.selection.baseOffset
                        //               : widget.controller.selection.extentOffset,
                        //           widget.controller.selection.extentOffset >
                        //                   widget.controller.selection.baseOffset
                        //               ? widget.controller.selection.extentOffset
                        //               : widget.controller.selection.baseOffset),
                        //       // !md真离谱这个baseOffset和extentOffset的顺序甚至还能和鼠标从哪边划相关……需要吗……
                        //       "");
                        // !这样也会导致删除了所有不是选中但是和选中内容相同的文本……没有更好的方法（buxianggaole）
                      }
                      // controller.text =
                      //     controller.text.substring(0, controller.text.length - 1);
                      // controller.
                    }),
                    calKeyBoardButton("=",
                        color: Colors.yellow[700], onPressed: handleGetRes),
                    // !真离谱就组件多传一次就报什么The argument type 'Function' can't be assigned to the parameter type 'dynamic Function()?'.……
                  ],
                )),
              ],
            )));
  }
}

class InputFieldWithDefault extends StatelessWidget {
  late TextEditingController controller;
  late String result;
  late List<String> options;
  late Function handleGetRes;
  // final FocusNode focusNode = FocusNode();
  InputFieldWithDefault(
      {required this.controller,
      required this.result,
      required this.options,
      required this.handleGetRes});
  @override
  Widget build(BuildContext context) {
    // controller?.addListener(() {
    //   controller?.text = expressionFormat(controller?.text ?? "");
    // });
    return Row(
      children: [
        Expanded(
            child: Stack(
          alignment: Alignment.centerRight,
          children: [
            // KeyboardListener(
            //     // focusNode: focusNode,
            //     focusNode: FocusNode(),
            //     onKeyEvent: (value) {
            //       if (value.logicalKey.keyLabel == "Backspace" &&
            //           controller.text.length > 0)
            //         controller.text = controller.text
            //             .substring(0, controller.text.length - 1);
            //       else if (value.logicalKey.keyLabel == "Enter" &&
            //           controller.text.length > 0) {
            //         handleGetRes();
            //       }
            //     },
            //     child:
            TextField(
              autofocus: true,
              // !额好像没用？
              controller: controller,
              // focusNode: focusNode,
              // !？？？莫名其妙输入没有光标只能从头插入，加了这个过一会才好，现在不加又行了？？？
              // onChanged: (str) {
              //   controller?.text = expressionFormat(controller.text ?? "");
              // },
              // onChanged: (value){if()},
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-*/]*$'))
              // ],
              // !这种方式只要输入一个非法字符就会清空……
              decoration: InputDecoration(
                  // enabledBorder:
                  hintText: '用键盘或下方按钮输入表达式，或在后面的按钮选择一个输入样例',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  // suffixIconColor: Colors.yellow[400],
                  // prefixIconColor: Colors.yellow[400],
                  // hoverColor: Colors.yellow[400],
                  // fillColor: Colors.yellow[400],
                  // focusColor: Colors.yellow[400],
                  // !md就是改不了输入时的边框颜色……
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[400]!, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.yellow[600]!, width: 2),
                      borderRadius: BorderRadius.circular(10))
                  // !麻了这边原来叫BorderSide……
                  ),
            ),
            Positioned(
              child: Text(
                result != "" ? "= " + result : "",
                style: TextStyle(fontSize: 20, height: 0.3),
                // !激进地设置height成了0.3/汗
              ),
              right: 10,
            )
            // Text(result),
          ],
        )),
        // Positioned(child:
        // Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        PopupMenuButton(
            tooltip: "输入样例",
            icon: Icon(Icons.arrow_drop_down),
            itemBuilder: (context) => options
                .map((String sample) => PopupMenuItem(
                    child: Text(sample),
                    value: sample,
                    onTap: () {
                      if (controller.text == sample) return;
                      if (controller.text != "") {
                        // !Dialog的写法！！！
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text(
                                      "警告",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    content: Text("当前输入框内有内容，是否覆盖？"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            controller.text = sample;
                                            Navigator.pop(context);
                                          },
                                          child: const Text("覆盖")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("取消"))
                                    ]));
                      } else
                        controller.text = sample;
                      // controller.value = TextEditingValue(text: sample);
                    }))
                .toList(),
            //  [
            //       PopupMenuItem(child: Text('Option 1'), value: 1),
            //       PopupMenuItem(child: Text('Option 2'), value: 2),
            //       PopupMenuItem(child: Text('Option 3'), value: 3)
            //     ],
            onSelected: (value) => print(value)),
        // ]),
        // right: 10,
        // top: 5,
        // bottom: 5,
        // )
      ],
    );
    // Autocomplete(
    //   optionsBuilder: (textEditingValue) =>
    //       ['Option 1', 'Option 2', 'Option 3'],
    // );
  }
}

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
