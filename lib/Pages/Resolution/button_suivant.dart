import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Config/fonction.dart';
import 'package:mplex/Pages/Optimisation/index.dart';
import 'package:mplex/Pages/Resolution/controller.dart';

import '../../page.dart';

class ButtonSuivant extends StatelessWidget {
  const ButtonSuivant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Tooltip(
          message: FormController.problemeContrainte.isNotEmpty &&
                  FormController.problemeVariable.isNotEmpty
              ? "Lancer l'optimisation"
              : "Compléter le formulaire",
          child: Container(
              decoration: BoxDecoration(
                  color: Get.theme.backgroundColor,
                  borderRadius: BorderRadius.circular(5)),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: Get.theme.primaryColor),
                child: Text(
                  "Lancer",
                  style: Get.theme.textTheme.bodyText2!.copyWith(
                      color: FormController.problemeContrainte.isNotEmpty &&
                              FormController.problemeVariable.isNotEmpty
                          ? Colors.white
                          : Colors.black38),
                ),
                onPressed: FormController.problemeContrainte.isNotEmpty &&
                        FormController.problemeVariable.isNotEmpty
                    ? () => Fonction.toOptimisation(
                        probleme: FormController.toProbleme().copyWith())
                    : null,
                // icon: Icon(
                //   Icons.lau,
                //   color: Get.theme.iconTheme.color,
                // ),
              )),
        ));
  }
}
