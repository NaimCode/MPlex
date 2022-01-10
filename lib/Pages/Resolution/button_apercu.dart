import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonApercu extends StatelessWidget {
  const ButtonApercu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Get.theme.backgroundColor,
            borderRadius: BorderRadius.circular(5)),
        child: ElevatedButton.icon(
            label: Text(
              "Aperçu",
              style: Get.theme.textTheme.bodyText2,
            ),
            onPressed: () => Get.defaultDialog(
                titleStyle: Get.textTheme.subtitle2,
                title: "",
                middleText: "",
                confirm: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    children: [
                      Text(
                        "Fonction objective:",
                        style: Get.theme.textTheme.caption,
                      )
                    ],
                  ),
                ),
                radius: 7),
            icon: Icon(
              Icons.visibility_outlined,
              color: Get.theme.iconTheme.color,
            )));
  }
}
