import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Pages/Resolution/controller.dart';
import 'package:provider/provider.dart';

class ButtonApercu extends StatelessWidget {
  const ButtonApercu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormController _ = context.watch<FormController>();
    return Tooltip(
      message: "Voir l'aperçu du problème",
      child: Container(
          decoration: BoxDecoration(
              color: Get.theme.backgroundColor,
              borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton(
            child: Text(
              "Aperçu",
              style: Get.theme.textTheme.bodyText2,
            ),
            onPressed: () => Get.defaultDialog(
                titleStyle: Get.textTheme.subtitle2!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                title: "",
                middleText: "",
                confirm: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    children: [
                      Text(
                        "Fonction objective",
                        style: Get.theme.textTheme.caption!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 3),
                      _.getApercuFonctionObjective(),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Text(
                        "Forme canonique:",
                        style: Get.theme.textTheme.caption!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 3),
                      _.getApercuFormeCanonique()
                    ],
                  ),
                ),
                radius: 7),
          )),
    );
  }
}
