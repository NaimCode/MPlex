import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/Class/variable.dart';
import 'package:mplex/Model/constante.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/Pages/Resolution/controller.dart';
import 'package:mplex/Widgets/mini.dart';

class FormVariables extends StatelessWidget {
  const FormVariables({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardForm(
        widget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Donner les variables de décision",
          style: Get.theme.textTheme.subtitle2,
        ),
        const Divider(),
        Obx(() => Wrap(
              runSpacing: 15,
              spacing: 15,
              children: [
                ...FormController.problemeVariable
                    .map((element) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Get.theme.scaffoldBackgroundColor),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                          ),
                        ))
                    .toList(),
                IconButton(
                    tooltip: "Ajouter",
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () async {
                      TextEditingController controller =
                          TextEditingController();
                      var check = await Get.defaultDialog(
                          actions: [
                            TextButton(
                                onPressed: () => Get.back(result: 0),
                                child: Text(
                                  "Annuler",
                                  style: Get.theme.textTheme.bodyText2,
                                )),
                            OutlinedButton(
                                onPressed: () => Get.back(
                                    result: double.parse(controller.text)),
                                child: Text(
                                  "Ajouter",
                                  style: Get.theme.textTheme.bodyText2,
                                ))
                          ],
                          titleStyle: Get.textTheme.caption,
                          radius: 7,
                          title: "",
                          // titleStyle: Get.theme.textTheme.sub,
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    textDirection: TextDirection.rtl,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        hintTextDirection: TextDirection.rtl),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                VariableNameWidget(
                                    number:
                                        FormController.problemeVariable.length +
                                            1)
                              ],
                            ),
                          ));

                      if (check != 0) {
                        FormController.problemeVariable.add(Variable(
                            name:
                                "X${FormController.problemeVariable.length + 1}",
                            value: check,
                            variableType: VariableType.DECISION));
                      }
                    },
                    icon: const Icon(Icons.add_box_rounded))
              ],
            ))
      ],
    ));
  }
}
