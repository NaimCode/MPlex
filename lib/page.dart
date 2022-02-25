import 'dart:ui';

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
        body: Stack(children: [
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/bg_4.jpg"))),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.blue.withOpacity(0),
              ),
            ),
          )),
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [const LeftSide(), Expanded(child: widget.rightSide)],
      ),
    ]));
  }
}
