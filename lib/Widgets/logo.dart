import 'package:flutter/material.dart';
import 'package:mplex/Config/get_controller.dart';
import 'package:mplex/Model/constante.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox(
              height: 30,
              child: Image.asset(
                MyGetController.isCollapse.value
                    ? "assets/logo.png"
                    : "assets/logo_inline.png",
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
