// td 现在能跑就行但是记得整理拆分组件结构……
// !额这个又不要求一定要有_了……
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mecalculator/Components/input_preview.dart';
import 'package:mecalculator/main.dart';

List<String> input1 = [];
List<String> input2 = [];
// !……………………完全可以放全局变量这里啊……
const List<List<String>> options = [
  ["1 1"],
  ["1 2", "1 1"],
  ["-1.5 1"],
  ["2 2", "-1 2"],
  ["1.5 2", "-0.3 1"],
];

class PageMultinomial extends StatefulWidget {
  // !命名规范要求就UpperCamelCase而不要_
  @override
  State<PageMultinomial> createState() => _PageMultinomialState();
}

class _PageMultinomialState extends State<PageMultinomial> {
  // List<String> inputs = ["",""];
  // String input2 = "";
  bool manualN = false;
  int n1 = 0, n2 = 0;
  String x = "";
  String mode = "--cal";
  String result = "";
  // int? result = null;
  // !Redundant initialization to 'null'.
  void handleGetRes() {
    // late String modeCommand;
    if (mode == "--cal" && x == "") {
      // !尽管在console里面添加了检测参数数量的逻辑但是似乎无效还是在这里判断……
      setState(() {
        result = "err: 未输入x";
      });
      return;
      // !额注意这个不要放到setState里面了……
    }
    setState(() {
      result = getCalRes(mode == "--cal"
          ? [
              // dtd implement
              "-M",
              mode,
              x,
              // mode == "--cal" ? [mode, x] : [mode],
              // !呜好不灵活
              input1.length.toString() + " " + input1.join(' '),
              input2.isEmpty
                  ? ""
                  : input2.length.toString() + " " + input2.join(' ')
            ]
          : [
              "-M",
              mode,
              // mode == "--cal" ? [mode, x] : [mode],
              // !呜好不灵活
              input1.length.toString() + " " + input1.join(' '),
              input2.isEmpty
                  ? ""
                  : input2.length.toString() + " " + input2.join(' ')
            ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> MultinomialsWidgets1 = [];
    List<Widget> MultinomialsWidgets2 = [];
    for (var i = 0; i < input1.length; i++) {
      MultinomialsWidgets1.add(Multinomial(
          index: i,
          handleChanged: (TextEditingController _controller1,
              TextEditingController _controller2) {
            // setState(() {
            if (_controller1.text.isEmpty && _controller2.text.isEmpty)
              input1.removeAt(i);
            if (_controller1.text.isEmpty || _controller2.text.isEmpty) return;
            input1[i] = _controller1.text + " " + _controller2.text;
            // });
            // !忘记用setState了……但是刚好实现了回车再检测的效果所以;)
            // !额其实是之前设置的Enter计算结果……
            // dtd不是……什么原理……check一下以后用得上
            // !哈哈哈就setState上来说flutter比React方便哈哈哈
          },
          multinomialIndicator1: input1[i].split(' ')[0],
          multinomialIndicator2: input1[i].split(' ')[1]));
    }
    MultinomialsWidgets1.add(Multinomial(
      index: input1.length + 1,
      handleChanged: (TextEditingController _controller1,
          TextEditingController _controller2) {
        if (_controller1.text.isEmpty || _controller2.text.isEmpty) return;
        setState(() {
          // td此时存在该输入框焦点重新到开头的问题……
          input1.add(_controller1.text + " " + _controller2.text);
        });
      },
      multinomialIndicator1: "",
      multinomialIndicator2: "",
      isLast: true,
    ));
    MultinomialsWidgets1.add(SizedBox(
      // !这个似乎不能直接再使用的时候再加……报错自己再看吧……
      width: 30,
    ));
    if (mode != "--cal" && mode != "--de")
      for (var i = 0; i < input2.length; i++) {
        MultinomialsWidgets2.add(Multinomial(
            index: i,
            handleChanged: (TextEditingController _controller1,
                TextEditingController _controller2) {
              // setState(() {
              if (_controller1.text.isEmpty && _controller2.text.isEmpty)
                input2.removeAt(i);
              if (_controller1.text.isEmpty || _controller2.text.isEmpty)
                return;
              input2[i] = _controller1.text + " " + _controller2.text;
              // });
            },
            multinomialIndicator1: input2[i].split(' ')[0],
            multinomialIndicator2: input2[i].split(' ')[1]));
      }
    MultinomialsWidgets2.add(Multinomial(
      index: input1.length + 1,
      handleChanged: (TextEditingController _controller1,
          TextEditingController _controller2) {
        if (_controller1.text.isEmpty || _controller2.text.isEmpty) return;
        setState(() {
          input2.add(_controller1.text + " " + _controller2.text);
        });
      },
      multinomialIndicator1: "",
      multinomialIndicator2: "",
      isLast: true,
    ));
    MultinomialsWidgets2.add(SizedBox(
      width: 30,
    ));
    return Expanded(
        child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              // if (event is KeyEvent) {
              // if(event.logicalKey.keyLabel == "Enter"){e

              // }
              switch (event.logicalKey.keyLabel) {
                case "=":
                case "Enter":
                  // handleGetRes();
                  setState(() {});
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //**----------------------------MainContentFlex-----------------------------------------------------
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child:
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  //**----------------------------n1,n2-----------------------------------------------------
                                  // (mode == "--cal" || mode == "--de")&&const Text("n = ")
                                  // !呜好不灵活……
                                  Text((mode == "--cal" || mode == "--de")
                                      ? "n = "
                                      : "n1 = "),
                                  // !An InputDecorator, which is typically created by a TextField, cannot have an unbounded width.
// !This happens when the parent widget does not provide a finite width constraint. For example, if the InputDecorator is contained by a Row, then its width must be constrained. An Expanded widget or a SizedBox can be used to constrain the width of the InputDecorator or the TextField that contains it.
// !意思是用个Expanded可以是吧……
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minWidth: 50, maxWidth: 90),
                                    // !额默认就采用了maxWidth……
                                    // !嗯或者再人工加个constrain也可以
                                    child: TextField(
                                      // !FT:TextField不能根据自身内容自动调整大小……
                                      // expands: true,
                                      enabled: false,
                                      decoration: InputDecoration(
                                          hintText: "${input1.length}(自动计算)",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.yellow,
                                                  width: 2))),
                                      onChanged: (value) {
                                        n1 = int.parse(value);
                                      },
                                    ),
                                  ),

                                  // !行吧当作和React一样吧……不能有两个组件……
                                  // !诶诶欸？？！！去掉{}就能正常条件渲染了？……噢噢加的()……
                                  ClipRect(
                                      // !依然有溢出报错的红色竖条……
                                      // !算了FT说flutter实际上还是很灵活的运行时应该不要紧吧()
                                      child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    width: mode == "--cal" || mode == "--de"
                                        ? 0
                                        : 150,
                                    child: Row(
                                      children: [
                                        Text("n2 = "),
                                        // !An InputDecorator, which is typically created by a TextField, cannot have an unbounded width.
// !This happens when the parent widget does not provide a finite width constraint. For example, if the InputDecorator is contained by a Row, then its width must be constrained. An Expanded widget or a SizedBox can be used to constrain the width of the InputDecorator or the TextField that contains it.
// !意思是用个Expanded可以是吧……
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              minWidth: 50, maxWidth: 90),
                                          // !额默认就采用了maxWidth……
                                          // !嗯或者再人工加个constrain也可以
                                          child: TextField(
                                            // !FT:TextField不能根据自身内容自动调整大小……
                                            enabled: false,
                                            // expands: true,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "${input2.length}(自动计算)",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.yellow,
                                                            width: 2))),
                                            onChanged: (value) {
                                              n2 = int.parse(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                              SizedBox(height: 10),
                              // Stack(
                              // td害之前的组件没做好复用性不想整理了就这样吧
                              // children: [
                              //**----------------------------MultinomialInput1-----------------------------------------------------
                              Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[300]),
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      SingleChildScrollView(
                                        // !赞
                                        scrollDirection: Axis.horizontal,
                                        // !默认用的vertical……
                                        child: Row(
                                            // !害不支持index就原始的ifor吧……
                                            children: MultinomialsWidgets1
                                            //  [for(var i=0;i<input1.length;i++){
                                            //   String data = input1[i].split(' ');
                                            //   return Text(data[0])
                                            // }]
                                            ),
                                      ),
                                      PopupMenuButton(
                                        tooltip: "输入样例",
                                        icon: Icon(Icons.arrow_drop_down),
                                        itemBuilder: (context) => options
                                            .map(
                                                (List<String> sample) =>
                                                    PopupMenuItem(
                                                        child: Text(
                                                            sample.join(' ')),
                                                        value: sample,
                                                        onTap: () {
                                                          if (listEquals(
                                                              input1, sample))
                                                            // if (input1.every((input)=>sample.contains(input)))
                                                            return;
                                                          if (input1.length !=
                                                              0) {
                                                            // !Dialog的写法！！！
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (context) =>
                                                                    AlertDialog(
                                                                        title:
                                                                            Text(
                                                                          "警告",
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        ),
                                                                        content:
                                                                            Text("当前输入框内有内容，是否覆盖？"),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  // input1 = sample;
                                                                                  // !注意这样依然传了引用导致无法修改……
                                                                                  input1 = [
                                                                                    ...sample
                                                                                  ];
                                                                                  result = "";
                                                                                  // !等等原来dart也有这种展开语法？？？
                                                                                });
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
                                                            setState(() {
                                                              // input1 = sample;
                                                              input1 = [
                                                                ...sample
                                                              ];
                                                              result = "";
                                                              // !等等原来dart也有这种展开语法？？？
                                                            });
                                                          // controller.value = TextEditingValue(text: sample);
                                                        }))
                                            .toList(),
                                      )
                                    ],
                                  )),
                              // Positioned(
                              //   child: PopupMenuButton(
                              //       itemBuilder: (BuildContext context) => []),
                              //   top: 5,
                              //   bottom: 5,
                              //   right: 10,
                              // )
                              // ],
                              // ),
                              //**----------------------------ModeSelect-----------------------------------------------------
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DropdownButton(
                                    value: mode,
                                    // !注意这里要手动指定value不然没显示……
                                    // !value的修改也要自己手动setState……,
                                    focusColor: Colors.white,
                                    onChanged: (value) {
                                      mode = value.toString();
                                    },
                                    items: [
                                      buildPopupMenuItem("求值", "--cal",
                                          onTapOthers: () {
                                        setState(() {
                                          result = "";
                                          n2 = 0;
                                          input2 = [];
                                        });
                                      }),
                                      buildPopupMenuItem("求导", "--de",
                                          onTapOthers: () {
                                        setState(() {
                                          result = "";
                                          x = "";
                                          n2 = 0;
                                          input2 = [];
                                        });
                                      }),
                                      buildPopupMenuItem("+", "--add",
                                          onTapOthers: () {
                                        x = "";
                                        result = "";
                                      }),
                                      buildPopupMenuItem("-", "--sub",
                                          onTapOthers: () {
                                        x = "";
                                        result = "";
                                      }),
                                      buildPopupMenuItem("×", "--mul",
                                          onTapOthers: () {
                                        x = "";
                                        result = "";
                                      }),
                                    ],
                                    // itemBuilder: (BuildContext context) => [
                                    //       buildPopupMenuItem("求值", "--cal"),
                                    //       buildPopupMenuItem("求导", "--de"),
                                    //       buildPopupMenuItem("+", "--add"),
                                    //       buildPopupMenuItem("-", "--sub"),
                                    //       buildPopupMenuItem("×", "--mul"),
                                    //     ]
                                  ),
                                  if (mode == "--cal")
                                    Row(
                                      // mainAxisSize: MainAxisSize.max,
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      // !？？意思是嵌套的Row这两个会失效？
                                      children: [
                                        Text("x = "),
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: TextField(
                                            // value: x,
                                            onChanged: (newX) {
                                              setState(() {
                                                x = newX;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                              //**----------------------------MultinomialInput2-----------------------------------------------------
                              if (mode != "--cal" && mode != "--de")
                                Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[300]),
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        SingleChildScrollView(
                                          // !赞
                                          scrollDirection: Axis.horizontal,
                                          // !默认用的vertical……
                                          child: Row(
                                              // !害不支持index就原始的ifor吧……
                                              children: MultinomialsWidgets2
                                              //  [for(var i=0;i<input1.length;i++){
                                              //   String data = input1[i].split(' ');
                                              //   return Text(data[0])
                                              // }]
                                              ),
                                        ),
                                        PopupMenuButton(
                                          tooltip: "输入样例",
                                          icon: Icon(Icons.arrow_drop_down),
                                          itemBuilder: (context) => options
                                              .map(
                                                  (List<String> sample) =>
                                                      PopupMenuItem(
                                                          child: Text(
                                                              sample.join(' ')),
                                                          value: sample,
                                                          onTap: () {
                                                            if (listEquals(
                                                                input2, sample))
                                                              return;
                                                            if (input2.length !=
                                                                0) {
                                                              // !Dialog的写法！！！
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (context) =>
                                                                      AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            "警告",
                                                                            style:
                                                                                TextStyle(color: Colors.red),
                                                                          ),
                                                                          content:
                                                                              Text("当前输入框内有内容，是否覆盖？"),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    input2 = [
                                                                                      ...sample
                                                                                    ];
                                                                                    result = "";
                                                                                  });
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
                                                              setState(() {
                                                                input2 = [
                                                                  ...sample
                                                                ];
                                                                result = "";
                                                              });
                                                            // controller.value = TextEditingValue(text: sample);
                                                          }))
                                              .toList(),
                                        )
                                      ],
                                    )),
                              // ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    onPressed: handleGetRes,
                                    child: const Text("计算")),
                              ),
                              InputPreview(mode == "--cal"
                                  ? [
                                      "-M",
                                      mode,
                                      x,
                                      "\"" +
                                          input1.length.toString() +
                                          " " +
                                          input1.join(' ') +
                                          "\"",
                                      input2.isEmpty
                                          ? ""
                                          : "\"" +
                                              input2.length.toString() +
                                              " " +
                                              input2.join(' ') +
                                              "\""
                                      // !嗯传""可以相当于忽略
                                    ]
                                  : [
                                      "-M",
                                      mode,
                                      "\"" +
                                          input1.length.toString() +
                                          " " +
                                          input1.join(' ') +
                                          "\"",
                                      input2.isEmpty
                                          ? ""
                                          : "\"" +
                                              input2.length.toString() +
                                              " " +
                                              input2.join(' ') +
                                              "\""
                                      // !嗯传""可以相当于忽略
                                    ]),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                // color: Colors.grey[200],
                                // !注意color不能和decoration共存
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey[500]!, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  result == ""
                                      ? "未计算"
                                      : result.startsWith("err: ")
                                          ? result.replaceAll('\n', '')
                                          : "计算结果：" +
                                              result.replaceAll('\n', ''),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: result.startsWith("err: ")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                              ),
                            ]))))));
  }

  DropdownMenuItem buildPopupMenuItem(String text, String mode,
      {Function? onTapOthers}) {
    return DropdownMenuItem(
        child: Text(text),
        value: mode,
        onTap: () {
          setState(() => this.mode = mode);
          if (onTapOthers != null) onTapOthers();
        });
  }
}

class Multinomial extends StatelessWidget {
  late bool isLast;
  late int index;
  late Function(TextEditingController _controller1,
      TextEditingController _controller2) handleChanged;
  late String multinomialIndicator1, multinomialIndicator2;
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  Multinomial(
      {required int index,
      required this.handleChanged,
      required this.multinomialIndicator1,
      required this.multinomialIndicator2,
      this.isLast = false});
  // void handleChanged() {
  //   if (_controller1.text.isEmpty || _controller2.text.isEmpty) return;
  //   if(multinomialIndex == 0)
  //   input1[index] = _controller1.text + " " + _controller2.text;
  //   else
  //   input2[index] = _controller1.text + " " + _controller2.text;
  // }

  @override
  Widget build(BuildContext context) {
    _controller1.text = multinomialIndicator1;
    _controller2.text = multinomialIndicator2;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ConstrainedBox(
        //     constraints: BoxConstraints(
        //         minWidth: 20,
        //         maxWidth: 30,
        //         minHeight: 20,
        //         maxHeight: 20),
        SizedBox(
            width: 50,
            height: 40,
            child: TextField(
              // !鬼知道这里输入的文字为什么会到下面去了……
              // expands: false,
              controller: _controller1,
              onChanged: (_) {
                handleChanged(_controller1, _controller2);
              },
              textAlign: TextAlign.end,
              textAlignVertical: TextAlignVertical(y: -1),
              // !其实用y=-1一样的……
              decoration: InputDecoration(
                contentPadding:
                    // !没用啊……
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              ),
              style: TextStyle(
                fontSize: 30,
              ),
              // decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color: Colors.black,
              //             width: 2))),
            )),
        // Text(input.split(' ')[0]),
        //**----------------------------X^-----------------------------------------------------
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "x",
              style: TextStyle(fontSize: 35),
            ),
            Container(
                width: 40,
                height: 35,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                  controller: _controller2,
                  onChanged: (_) {
                    handleChanged(_controller1, _controller2);
                  },
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  ),

                  // input.split(' ')[1],

                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
        if (!isLast)
          Text(" + ",
              style: TextStyle(
                fontSize: 30,
              )),
        // TextField()
      ],
    );
  }
}

// class MultinomialInputField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Row(children: []),
//     );
//   }
// }
class TextFieldWithValue extends StatelessWidget {
  late double value;
  late double? fontSize;
  late Function(String) onChanged;
  final TextEditingController controller = TextEditingController();
  TextFieldWithValue(
      {required this.value, this.fontSize, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    controller.text = value.toString();
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: fontSize),
      onChanged: onChanged,
    );
  }
}
