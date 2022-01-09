import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/Class/contrainte.dart';
import 'package:mplex/Model/Class/variable.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/Pages/Resolution/controller.dart';
import 'package:mplex/Widgets/mini.dart';

class FormContraintes extends StatelessWidget {
  const FormContraintes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CardForm(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Donner les contraintes",
                      style: Get.theme.textTheme.subtitle2,
                    ),
                  ),
                  const ButtonAddContrainte(),
                  Visibility(
                    visible: FormController.problemeContrainte.isNotEmpty,
                    child: Tooltip(
                      message: "Effacer les contraintes",
                      child: TextButton.icon(
                          style: TextButton.styleFrom(primary: Colors.red),
                          label: Text("Effacer", style: Get.textTheme.caption),
                          // tooltip: "Effacer",
                          // focusColor: Colors.transparent,
                          // splashColor: Colors.transparent,
                          // highlightColor: Colors.transparent,
                          // hoverColor: Colors.transparent,
                          onPressed: () => Get.defaultDialog(
                                title: "Confirmation",
                                middleTextStyle: Get.textTheme.caption,
                                middleText: "Effacer toutes les contraintes?",
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
              ...FormController.problemeContrainte
                  .map((element) => element.getWidget())
                  .toList()
              // const SizedBox(height: 15),
            ],
          ),
        ));
  }
}

class ButtonAddContrainte extends StatelessWidget {
  const ButtonAddContrainte({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Ajouter une contrainte",
      child: TextButton.icon(
        style: TextButton.styleFrom(primary: Get.theme.primaryColor),
        label: Text("Ajouter", style: Get.textTheme.caption),
        icon: const Icon(Icons.add_box_rounded),
        onPressed: () async {
          List<TextEditingController> controller = [];
          for (int i = 0; i < FormController.problemeVariable.length; i++) {
            controller.add(TextEditingController());
          }
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          Rx<Inegalite> inegalite = Inegalite.INF_EGAL.obs;
          TextEditingController controllerValue = TextEditingController();
          var check = await Get.defaultDialog(
              actions: [
                TextButton(
                    onPressed: () => Get.back(result: false),
                    child: Text(
                      "Annuler",
                      style: Get.theme.textTheme.bodyText2,
                    )),
                OutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Get.back(result: true);
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
              content: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...controller
                          .map(
                            (c) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 55,
                                    child: TextFormField(
                                      controller: c,
                                      validator: (v) {
                                        if (double.tryParse(v!) == null) {
                                          return "Erreur";
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.right,
                                      //textDirection: TextDirection.rtl,
                                      decoration: const InputDecoration(
                                          filled: true,
                                          hintTextDirection: TextDirection.rtl),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  VariableNameWidget2(
                                      number: FormController
                                          .problemeVariable[
                                              controller.indexOf(c)]
                                          .name)
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      const SizedBox(width: 20),
                      Obx(
                        () => DropdownButton<Inegalite>(
                            iconSize: 12,
                            underline: const SizedBox(),
                            // hint:  Text("Select item"),
                            value: inegalite.value,
                            onChanged: (var value) {
                              inegalite.value = value!;
                            },
                            items: const [
                              DropdownMenuItem(
                                  value: Inegalite.INF_EGAL,
                                  child:
                                      FaIcon(FontAwesomeIcons.lessThanEqual)),
                              DropdownMenuItem(
                                  value: Inegalite.INF,
                                  child: FaIcon(FontAwesomeIcons.lessThan)),
                              DropdownMenuItem(
                                  value: Inegalite.SUP_EGAL,
                                  child: FaIcon(
                                      FontAwesomeIcons.greaterThanEqual)),
                              DropdownMenuItem(
                                  value: Inegalite.SUP,
                                  child: FaIcon(FontAwesomeIcons.greaterThan)),
                              DropdownMenuItem(
                                  value: Inegalite.EGAL,
                                  child: FaIcon(FontAwesomeIcons.equals)),
                            ]),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 70,
                        child: TextFormField(
                          controller: controllerValue,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          validator: (v) {
                            if (double.tryParse(v!) == null) {
                              return "Erreur";
                            } else {
                              return null;
                            }
                          },
                          //textDirection: TextDirection.rtl,
                          decoration: const InputDecoration(
                              filled: true,
                              hintTextDirection: TextDirection.rtl),
                        ),
                      ),
                      // VariableNameWidget(
                      //     number: FormController.problemeVariable.length + 1)
                    ],
                  ),
                ),
              ));
          if (check) {
            Contrainte contrainte = Contrainte(
                variables: controller
                    .map((e) => Variable(
                        name: FormController
                            .problemeVariable[controller.indexOf(e)].name,
                        value: double.parse(e.text),
                        variableType: VariableType.DECISION))
                    .toList(),
                inegalite: inegalite.value,
                value: double.parse(controllerValue.value.text));
            FormController.problemeContrainte.add(contrainte);
          }
        },
      ),
    );
  }
}
