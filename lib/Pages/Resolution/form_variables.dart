import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
        widget: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Donner les variables de décision",
                        style: Get.theme.textTheme.subtitle2,
                      ),
                    ),
                    const ButtonAddVariable(),
                    Visibility(
                      visible: FormController.problemeVariable.isNotEmpty,
                      child: Tooltip(
                        message: "Effacer les variables",
                        child: TextButton.icon(
                            style: TextButton.styleFrom(primary: Colors.red),
                            label:
                                Text("Effacer", style: Get.textTheme.caption),
                            // tooltip: "Effacer",
                            // focusColor: Colors.transparent,
                            // splashColor: Colors.transparent,
                            // highlightColor: Colors.transparent,
                            // hoverColor: Colors.transparent,
                            onPressed: () => Get.defaultDialog(
                                  title: "Confirmation",
                                  middleTextStyle: Get.textTheme.caption,
                                  middleText:
                                      "Ceci va entrainer l'effacement des contraintes",
                                  actions: [
                                    TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text(
                                          "Annuler",
                                          style: Get.theme.textTheme.bodyText2,
                                        )),
                                    OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            primary: Colors.red,
                                            onSurface: Colors.red),
                                        onPressed: () {
                                          FormController.problemeVariable
                                              .clear();
                                          FormController.problemeContrainte
                                              .clear();
                                          Get.back();
                                        },
                                        child: Text(
                                          "Effacer",
                                          style: Get.theme.textTheme.bodyText2,
                                        ))
                                  ],
                                  titleStyle: Get.textTheme.subtitle2,
                                  radius: 7,
                                ),
                            icon: const Icon(Icons.delete)),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: FormController.problemeVariable
                      .map((element) => element.getWidget())
                      .toList()
                      .cast(),
                )
              ],
            )));
  }
}

class ButtonAddVariable extends StatelessWidget {
  const ButtonAddVariable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Ajouter une variable",
      child: TextButton.icon(
        style: TextButton.styleFrom(primary: Get.theme.primaryColor),
        label: Text("Ajouter", style: Get.textTheme.caption),
        icon: const Icon(Icons.add_box_rounded),
        onPressed: () async {
          TextEditingController controller = TextEditingController();
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          var check = await Get.defaultDialog(
              actions: [
                TextButton(
                    onPressed: () => Get.back(result: 0),
                    child: Text(
                      "Annuler",
                      style: Get.theme.textTheme.bodyText2,
                    )),
                OutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Get.back(result: double.parse(controller.text));
                      }
                    },
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
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          validator: (v) {
                            double? check = double.tryParse(controller.text);
                            if (check == null) {
                              return "Erreur";
                            } else {
                              return null;
                            }
                          },
                          controller: controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          //textDirection: TextDirection.rtl,
                          decoration: const InputDecoration(
                              filled: true,
                              hintTextDirection: TextDirection.rtl),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    VariableNameWidget(
                        number: FormController.problemeVariable.length + 1)
                  ],
                ),
              ));

          if (check != 0) {
            FormController.problemeVariable.add(Variable(
                name: "x${FormController.problemeVariable.length + 1}",
                value: check,
                variableType: VariableType.DECISION));
          }
        },
      ),
    );
  }
}
