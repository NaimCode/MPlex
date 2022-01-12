import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mplex/Model/Class/contrainte.dart';
import 'package:mplex/Model/Class/forme.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Model/Class/variable.dart';
import 'package:mplex/Model/enum.dart';

class FormController {
  static Rx<ProblemeType> problemeTypeController = ProblemeType.MAX.obs;
  static Rx<TextEditingController> problemeName = TextEditingController().obs;
  static RxList problemeVariable = [].obs;
  static RxList problemeContrainte = [].obs;

  static Probleme toProbleme() {
    return Probleme(
        forme: Forme(
            type: FormeType.CANONIQUE,
            contraintes: problemeContrainte
                .map((element) => element.copyWith())
                .toList()
                .cast()),
        type: problemeTypeController.value,
        name: "Z",
        variables: problemeVariable.map((element) => element).toList().cast());
  }

  static Widget getApercuFonctionObjective() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          problemeTypeController.value == ProblemeType.MAX ? "Max" : "Min",
          style: Get.theme.textTheme.headline6!
              .copyWith(color: Get.theme.focusColor),
        ),
        const SizedBox(width: 3),
        Text(
          "Z",
          style: Get.textTheme.headline6,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: FaIcon(FontAwesomeIcons.equals, size: 10),
        ),
        ...problemeVariable.map((element) => element
            .getWidgetWithoutContainer(problemeVariable.indexOf(element) == 0))
      ],
    );
  }

  static Widget getApercuFormeCanonique() {
    List<Contrainte> cons = [];
    for (int i = 0; i < problemeContrainte.length; i++) {
      cons.add(problemeContrainte[i].copyWith());
    }
    for (int i = 0; i < cons.length; i++) {
      cons[i].variables.removeWhere((element) => element.value == 0);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: cons
            .map((e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...e.variables.map((element) =>
                        element.getWidgetWithoutContainer(
                            e.variables.indexOf(element) == 0)),
                    Transform.scale(
                      scale: 0.6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: e.getInegalityIcon(),
                      ),
                    ),
                    Text(e.value.toInt().toString(),
                        style: Get.textTheme.bodyText2!.copyWith(fontSize: 17))
                  ],
                ))
            .toList(),
      ),
    );
  }
}
