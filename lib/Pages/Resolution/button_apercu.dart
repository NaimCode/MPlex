import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Pages/Resolution/controller.dart';

class ButtonApercu extends StatelessWidget {
  const ButtonApercu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Voir l'aperçu du problème",
      child: Container(
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
                  title: "Aperçu",
                  middleText: "",
                  confirm: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Column(
                      children: [
                        Text(
                          "Fonction objective:",
                          style: Get.theme.textTheme.caption,
                        ),
                        const SizedBox(height: 3),
                        FormController.getApercuFonctionObjective(),
                        const SizedBox(height: 6),
                        Text(
                          "Forme canonique:",
                          style: Get.theme.textTheme.caption,
                        ),
                        const SizedBox(height: 3),
                        FormController.getApercuFormeCanonique()
                      ],
                    ),
                  ),
                  radius: 7),
              icon: Icon(
                Icons.visibility_outlined,
                color: Get.theme.iconTheme.color,
              ))),
    );
  }
}
