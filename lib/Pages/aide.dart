import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/enum.dart';

class Aide extends StatefulWidget {
  const Aide({Key? key}) : super(key: key);

  @override
  _AideState createState() => _AideState();
}

List<Map<String, String>> _list = [
  {
    "desc": "Choisissez le type de problème que vous essayez de résoudre",
    "image": "assets/1.png"
  },
  {"desc": "Ajouter les variables de décisions", "image": "assets/2.png"},
  {
    "desc": "Exemple d'un ajoût d'une variable de décision",
    "image": "assets/3.png"
  },
  {
    "desc":
        "Une fois que vous avez fini d'insérer vos variables, vous pouvez passer aux contraintes",
    "image": "assets/4.png"
  },
  {"desc": "Exemple d'un ajoût d'une contrainte", "image": "assets/5.png"},
  {
    "desc": "Vous pouvez maintenant lancer l'opération",
    "image": "assets/6.png"
  },
];

class _AideState extends State<Aide> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Scrollbar(
            controller: scrollController,
            child: ListView(
              padding: const EdgeInsets.only(top: 13.0, left: 13, right: 13),
              controller: scrollController,
              children: [
                Text(
                  "Etapes de résolution",
                  style: Get.theme.textTheme.headline5!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Veuillez suivre les étapes ci-après si jamais vous êtes perdu:",
                  style: Get.theme.textTheme.caption!.copyWith(
                    color: Colors.white,
                  ),
                ),
                ..._list.map((e) => AideItem(item: e, num: _list.indexOf(e))),
                const SizedBox(
                  height: 50,
                )
              ],
            )),
      ),
    );
  }
}

class AideItem extends StatelessWidget {
  final item;
  final int num;
  const AideItem({Key? key, required this.item, required this.num})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Image.asset(item["image"]),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Text((num + 1).toString()),
              ),
            ),
            title: Text(
              item["desc"],
              style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
