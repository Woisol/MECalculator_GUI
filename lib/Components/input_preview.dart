import 'package:flutter/material.dart';

class InputPreview extends StatelessWidget {
  late List<String> args;
  InputPreview(this.args);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text("命令预览：calculate.exe " + args.join(' '),
          style: TextStyle(fontSize: 15), textAlign: TextAlign.end),
    );
  }
}
