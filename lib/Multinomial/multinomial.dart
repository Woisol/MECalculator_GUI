// !额这个又不要求一定要有_了……
import 'package:flutter/material.dart';
import 'package:mecalculator/main.dart';

class PageMultinomial extends StatefulWidget {
  // !命名规范要求就UpperCamelCase而不要_
  @override
  State<PageMultinomial> createState() => _PageMultinomialState();
}

class _PageMultinomialState extends State<PageMultinomial> {
  List<String> inputs = [];
  bool manualN = false;
  int n = 0;
  String mode = "--cal";
  String result = "";
  // int? result = null;
  // !Redundant initialization to 'null'.
  void handleGetRes() {
    late String modeCommand;

    setState(() {
      result = getCalRes([
        "-M",
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      DropdownButton(
                        value: mode,
                        // !注意这里要手动指定value不然没显示……
                        // !value的修改也要自己手动setState……
                        onChanged: (value) {
                          mode = value.toString();
                        },
                        items: [
                          buildPopupMenuItem("求值", "--cal"),
                          buildPopupMenuItem("求导", "--de"),
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
                      )
                    ])))));
  }

  DropdownMenuItem buildPopupMenuItem(String text, String mode) {
    return DropdownMenuItem(
        child: Text(text),
        value: mode,
        onTap: () => setState(() => this.mode = mode));
  }
}

class MultinomialInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
