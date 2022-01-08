import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'get_controller.dart';

class MenuItem {
  String title;
  String route;
  IconData icon;
  MenuItem({
    required this.title,
    required this.route,
    required this.icon,
  });

  Widget getWidget() {
    bool isCurrent = Get.currentRoute.contains(route);
    bool isCollapse = MyGetController.isCollapse.value;
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: isCurrent ? Get.theme.primaryColor : null),
        child: Row(
          mainAxisAlignment:
              isCollapse ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Tooltip(
              message: title,
              child: Icon(
                icon,
                color: isCurrent ? Colors.white : Get.theme.iconTheme.color,
                size: Get.theme.iconTheme.size,
              ),
            ),
            SizedBox(width: isCollapse ? 0 : 20),
            Visibility(
              visible: !isCollapse,
              child: Flexible(
                child: Text(title,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: Get.theme.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: isCurrent
                            ? Colors.white
                            : Get.theme.textTheme.bodyText2!.color!
                                .withOpacity(0.5))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Menu {
  List<MenuItem> menu = [
    MenuItem(title: "Accueil", route: "/home", icon: Icons.home),
    MenuItem(
        title: "Résolution",
        route: "/resolution",
        icon: FontAwesomeIcons.subscript),
    MenuItem(
        title: "Sauvegarde",
        route: "/sauvegarde",
        icon: Icons.bookmark_outlined),
    MenuItem(title: "Aide", route: "/aide", icon: Icons.help_rounded),
  ];
  Widget getWidget() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: menu.map((e) => e.getWidget()).toList(),
        ),
      ),
    );
  }
}
