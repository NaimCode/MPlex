import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mplex/Config/theme.dart';
import 'package:mplex/Data/test.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Model/algorithme.dart';
import 'package:mplex/Model/constante.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/page.dart';
import 'package:provider/provider.dart';

import 'Config/databse.dart';
import 'Model/Class/tableau.dart';
import 'Pages/home.dart';

void main() async {
  var path = Directory.current.path;
  Hive.init("$path/hive/");
  await Hive.openBox("settings");
  runApp(MPlex());
}

class MPlex extends StatelessWidget {
  MPlex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box('settings').listenable(),
        builder: (context, box, widget) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: box.get("isDark") ? ThemeMPlex.dark : ThemeMPlex.light,
            initialRoute: "/home",
            getPages: [
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 400),
                  transition: Transition.circularReveal,
                  name: "/home",
                  page: () => Root(
                        rightSide: Home(),
                      )),
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 400),
                  transition: Transition.circularReveal,
                  name: "/resolution",
                  page: () => Root(
                        rightSide: Home(),
                      )),
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 400),
                  transition: Transition.circularReveal,
                  name: "/sauvegarde",
                  page: () => Root(
                        rightSide: Home(),
                      )),
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 400),
                  transition: Transition.circularReveal,
                  name: "/aide",
                  page: () => Root(
                        rightSide: Home(),
                      )),
            ],
          );
        });
  }
}
