import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mplex/Config/fonction.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Pages/Sauvegarde/sauvegarde_item.dart';
import 'package:mplex/Widgets/mini.dart';

class SauvegardePage extends StatefulWidget {
  const SauvegardePage({Key? key}) : super(key: key);

  @override
  _SauvegardePageState createState() => _SauvegardePageState();
}

class _SauvegardePageState extends State<SauvegardePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 13.0, right: 13, left: 13.0),
        child: ValueListenableBuilder(
            valueListenable: Hive.box("sauvegarde").listenable(),
            builder: (context, Box b, _) => ListView.builder(
                controller: ScrollController(),
                itemCount: b.length,
                itemBuilder: (context, index) =>
                    SauvegardeItem(p: b.getAt(index)))),
      ),
    );
  }
}
