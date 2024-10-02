import 'package:flutter/material.dart';
import 'package:mecalculator/Data_Process/data_process.dart';

class InputFieldWithDefault extends StatelessWidget {
  late TextEditingController controller;
  late String result;
  late List<String> options;
  InputFieldWithDefault(
      {required this.controller, required this.result, required this.options});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: controller,
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
                  borderSide: BorderSide(color: Colors.yellow[600]!, width: 2),
                  borderRadius: BorderRadius.circular(10))
              // !麻了这边原来叫BorderSide……
              ),
        )),
        // Positioned(child:
        Row(children: [
          Text(result),
          PopupMenuButton(
              tooltip: "输入样例",
              icon: Icon(Icons.arrow_drop_down),
              itemBuilder: (context) => options
                  .map((String sample) => PopupMenuItem(
                      child: Text(sample),
                      value: sample,
                      onTap: () {
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
        ]),
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
