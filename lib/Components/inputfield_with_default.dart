import 'package:flutter/material.dart';
import 'package:mecalculator/Data_Process/data_process.dart';

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
              controller: controller,
              // focusNode: focusNode,
              // !？？？莫名其妙输入没有光标只能从头插入，加了这个过一会才好，现在不加又行了？？？
              // onChanged: (str) {
              //   controller?.text = expressionFormat(controller.text ?? "");
              // },
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
