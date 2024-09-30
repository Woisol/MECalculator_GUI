// !额这个又不要求一定要有_了……
import 'package:flutter/material.dart';

class PageMultinomial extends StatefulWidget {
  // !命名规范要求就UpperCamelCase而不要_
  @override
  State<PageMultinomial> createState() => _PageMultinomialState();
}

class _PageMultinomialState extends State<PageMultinomial> {
  List<String> inputs = [];
  int n = 0;
  int operation = 0;
  int? result;
  // int? result = null;
  // !Redundant initialization to 'null'.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Multinomial"),
    );
  }
}
