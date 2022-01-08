import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DarkModeButton extends StatelessWidget {
  DarkModeButton({
    Key? key,
  }) : super(key: key);
  final Box b = Hive.box("settings");

  @override
  Widget build(BuildContext context) {
    bool isDark = b.get("isDark");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: () =>
              isDark ? b.put("isDark", false) : b.put("isDark", true),
          icon: Icon(
            isDark ? Icons.light_mode : Icons.dark_mode,
            color: isDark ? Colors.white : Get.theme.iconTheme.color,
          )),
      //)
    );
  }
}
