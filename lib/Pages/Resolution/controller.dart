import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mplex/Model/Class/forme.dart';
import 'package:mplex/Model/Class/variable.dart';
import 'package:mplex/Model/enum.dart';

class FormController {
  static Rx<ProblemeType> problemeTypeController = ProblemeType.MAX.obs;
  static Rx<TextEditingController> problemeName = TextEditingController().obs;
  static RxList problemeVariable = [].obs;
  static RxList problemeContrainte = [].obs;

  static Widget getApercuFonctionObjective() {
    return RichText(
        text: TextSpan(
            text: problemeTypeController.value == ProblemeType.MAX
                ? "Max"
                : "Min",
            //style:
            children: const [
          TextSpan(
            text: "Z",
            //style:
          ),
        ]));
  }
}
