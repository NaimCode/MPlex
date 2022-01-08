import 'dart:io';

import 'package:hive/hive.dart';

class Database {
  Box? settings;

  // Box b = await Hive.openBox('Settings');
  // if (!b.containsKey("isDark")) b.put("isDark", false);
  Database() {
    settings = Hive.box("settings");
  }
  static initDatabase() async {
    var path = Directory.current.path;
    Hive.init("$path/hive/");
    Box b = await Hive.openBox("settings");
    if (!b.containsKey("isDark")) b.put("isDark", false);
  }

  bool checkIsDark() {
    return settings!.get("isDark");
  }

  void setIsDark({required bool isDark}) {
    settings!.put("isDark", isDark);
  }
}
