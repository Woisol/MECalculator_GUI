// !额这个又不要求一定要有_了……
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mecalculator/Components/input_preview.dart';
import 'package:mecalculator/main.dart';

List<String> input1 = ["1 2", "1 1"];
List<String> input2 = [];
// !……………………完全可以放全局变量这里啊……

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
  int? x = null;
  String mode = "--cal";
  String result = "";
  // int? result = null;
  // !Redundant initialization to 'null'.
  void handleGetRes() {
    late String modeCommand;
    setState(() {
      result = getCalRes([
        // td implement
        "-M",
        mode,
        input1.length.toString() + input1.join(' '),
        input2.isEmpty ? "" : input2.length.toString() + input2.join(' ')
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
            if (_controller1.text.isEmpty && _controller2.text.isEmpty)
              input1.removeAt(i);
            if (_controller1.text.isEmpty || _controller2.text.isEmpty) return;
            input1[i] = _controller1.text + " " + _controller2.text;
            // !忘记用setState了……但是刚好实现了回车再检测的效果所以;)
            // td不是……什么原理……check一下以后用得上
          },
          multinomialIndicator1: input1[i].split(' ')[0],
          multinomialIndicator2: input1[i].split(' ')[1]));
    }
    MultinomialsWidgets1.add(Multinomial(
      index: input1.length + 1,
      handleChanged: (TextEditingController _controller1,
          TextEditingController _controller2) {
        if (_controller1.text.isEmpty || _controller2.text.isEmpty) return;
        input1.add(_controller1.text + " " + _controller2.text);
      },
      multinomialIndicator1: "",
      multinomialIndicator2: "",
      isLast: true,
    ));
    if (mode != "--cal" && mode != "--de")
      for (var i = 0; i < input2.length; i++) {
        MultinomialsWidgets2.add(Multinomial(
            index: i,
            handleChanged: (TextEditingController _controller1,
                TextEditingController _controller2) {
              if (_controller1.text.isEmpty || _controller2.text.isEmpty)
                return;
              input2[i] = _controller1.text + " " + _controller2.text;
            },
            multinomialIndicator1: input2[i].split(' ')[0],
            multinomialIndicator2: input2[i].split(' ')[1]));
      }
    MultinomialsWidgets2.add(Multinomial(
      index: input1.length + 1,
      handleChanged: (TextEditingController _controller1,
          TextEditingController _controller2) {
        if (_controller1.text.isEmpty || _controller2.text.isEmpty) return;
        input2.add(_controller1.text + " " + _controller2.text);
      },
      multinomialIndicator1: "",
      multinomialIndicator2: "",
      isLast: true,
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
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          //**----------------------------MainContentFlex-----------------------------------------------------
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child:
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // (mode == "--cal" || mode == "--de")&&const Text("n = ")
                              // !呜好不灵活……
                              Text((mode == "--cal" || mode == "--de")
                                  ? "n = "
                                  : "n1 = "),
                              // !An InputDecorator, which is typically created by a TextField, cannot have an unbounded width.
// !This happens when the parent widget does not provide a finite width constraint. For example, if the InputDecorator is contained by a Row, then its width must be constrained. An Expanded widget or a SizedBox can be used to constrain the width of the InputDecorator or the TextField that contains it.
// !意思是用个Expanded可以是吧……
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(minWidth: 50, maxWidth: 80),
                                // !额默认就采用了maxWidth……
                                // !嗯或者再人工加个constrain也可以
                                child: TextField(
                                  // !FT:TextField不能根据自身内容自动调整大小……
                                  // expands: true,
                                  decoration: InputDecoration(
                                      hintText: "(自动计算)",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.yellow, width: 2))),
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
                                width:
                                    mode == "--cal" || mode == "--de" ? 0 : 150,
                                child: Row(
                                  children: [
                                    Text("n2 = "),
                                    // !An InputDecorator, which is typically created by a TextField, cannot have an unbounded width.
// !This happens when the parent widget does not provide a finite width constraint. For example, if the InputDecorator is contained by a Row, then its width must be constrained. An Expanded widget or a SizedBox can be used to constrain the width of the InputDecorator or the TextField that contains it.
// !意思是用个Expanded可以是吧……
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          minWidth: 50, maxWidth: 80),
                                      // !额默认就采用了maxWidth……
                                      // !嗯或者再人工加个constrain也可以
                                      child: TextField(
                                        // !FT:TextField不能根据自身内容自动调整大小……
                                        // expands: true,
                                        decoration: InputDecoration(
                                            hintText: "(自动计算)",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow,
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
                          Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300]),
                              child: SingleChildScrollView(
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
                              )),
                          // ),
                          DropdownButton(
                            value: mode,
                            // !注意这里要手动指定value不然没显示……
                            // !value的修改也要自己手动setState……
                            onChanged: (value) {
                              mode = value.toString();
                            },
                            items: [
                              buildPopupMenuItem("求值", "--cal",
                                  onTapOthers: () {
                                setState(() {
                                  n2 = 0;
                                });
                              }),
                              buildPopupMenuItem("求导", "--de", onTapOthers: () {
                                setState(() {
                                  n2 = 0;
                                });
                              }),
                              buildPopupMenuItem("+", "--add"),
                              buildPopupMenuItem("-", "--sub"),
                              buildPopupMenuItem("×", "--mul"),
                            ],
                            // itemBuilder: (BuildContext context) => [
                            //       buildPopupMenuItem("求值", "--cal"),
                            //       buildPopupMenuItem("求导", "--de"),
                            //       buildPopupMenuItem("+", "--add"),
                            //       buildPopupMenuItem("-", "--sub"),
                            //       buildPopupMenuItem("×", "--mul"),
                            //     ]
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                                onPressed: handleGetRes,
                                child: const Text("计算")),
                          ),
                          InputPreview([
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
                                    input1.length.toString() +
                                    input2.join(' ') +
                                    "\""
                            // !嗯传""可以相当于忽略
                          ]),
                          Text(result == "" ? "" : "计算结果：" + result),
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
//     // td implement
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Row(children: []),
//     );
//   }
// }
