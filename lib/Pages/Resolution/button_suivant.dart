import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Config/fonction.dart';
import 'package:mplex/Pages/Optimisation/index.dart';
import 'package:mplex/Pages/Resolution/controller.dart';
import 'package:provider/provider.dart';
import '../../page.dart';

class ButtonSuivant extends StatelessWidget {
  const ButtonSuivant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormController _ = context.watch<FormController>();
    return Obx(
        () => _.problemeContrainte.isNotEmpty && _.problemeVariable.isNotEmpty
            ? Tooltip(
                message: _.problemeContrainte.isNotEmpty &&
                        _.problemeVariable.isNotEmpty
                    ? "Lancer l'optimisation"
                    : "Compléter le formulaire",
                child: Container(
                    decoration: BoxDecoration(
                        color: Get.theme.backgroundColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      child: Text(
                        "Lancer",
                        style: Get.theme.textTheme.bodyText2!
                            .copyWith(color: Colors.black),
                      ),
                      onPressed: _.problemeContrainte.isNotEmpty &&
                              _.problemeVariable.isNotEmpty
                          ? () => Fonction.toOptimisation(
                              probleme: _.toProbleme().copyWith())
                          : null,
                      // icon: Icon(
                      //   Icons.lau,
                      //   color: Get.theme.iconTheme.color,
                      // ),
                    )),
              )
            : Container());
  }
}
