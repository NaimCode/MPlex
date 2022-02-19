import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mplex/Config/theme.dart';
import 'package:mplex/Data/test.dart';
import 'package:mplex/Model/Class/contrainte.dart';
import 'package:mplex/Model/Class/forme.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/Model/constante.dart';
import 'package:mplex/Pages/Resolution/index.dart';
import 'package:mplex/Pages/Sauvegarde/index.dart';
import 'package:mplex/page.dart';

import 'Model/Class/variable.dart';
import 'Model/Class/variable.dart';
import 'Pages/home.dart';

void main() async {
  if (kIsWeb) {
    Hive.initFlutter();
  } else {
    var path = Directory.current.path;
    Hive.init(path + "/hive/");
  }

  Hive
    ..registerAdapter(ContrainteAdapter())
    ..registerAdapter(VariableAdapter())
    ..registerAdapter(VariableTypeAdapter())
    ..registerAdapter(FormeAdapter())
    ..registerAdapter(InegaliteAdapter())
    ..registerAdapter(ExceptionsAdapter())
    ..registerAdapter(SolutionTypeAdapter())
    ..registerAdapter(FormeTypeAdapter())
    ..registerAdapter(ProblemeTypeAdapter())
    ..registerAdapter(ProblemeAdapter());

  await Hive.openBox("settings");
  await Hive.openBox("sauvegarde");
  await Hive.openBox("test");
  if (Hive.box("settings").get("isDark") == null) {
    Hive.box("settings").put("isDark", false);
  }

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
            initialRoute: "/maximisation",
            getPages: [
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 700),
                  transition: Transition.fade,
                  name: "/home",
                  page: () => Root(
                        rightSide: Home(),
                      )),
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 700),
                  transition: Transition.fade,
                  name: "/maximisation",
                  page: () => const Root(
                        rightSide: Resolution(
                          type: ProblemeType.MAX,
                        ),
                      )),
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 700),
                  transition: Transition.fade,
                  name: "/minimisation",
                  page: () => const Root(
                        rightSide: Resolution(
                          type: ProblemeType.MIN,
                        ),
                      )),
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 700),
                  transition: Transition.fade,
                  name: "/sauvegarde",
                  page: () => const Root(
                        rightSide: SauvegardePage(),
                      )),
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 400),
                  transition: Transition.fade,
                  name: "/historique",
                  page: () => Root(
                        rightSide: Home(),
                      )),
              GetPage(
                  preventDuplicates: true,
                  transitionDuration: const Duration(milliseconds: 400),
                  transition: Transition.fade,
                  name: "/aide",
                  page: () => Root(
                        rightSide: Home(),
                      )),
            ],
          );
        });
  }
}
