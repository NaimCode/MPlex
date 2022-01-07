import 'package:flutter/material.dart';
import 'package:mplex/Widgets/leftSide.dart';

class Root extends StatefulWidget {
  final Widget rightSide;
  const Root({Key? key, required this.rightSide}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [const LeftSide(), Expanded(child: widget.rightSide)],
      ),
    );
  }
}
