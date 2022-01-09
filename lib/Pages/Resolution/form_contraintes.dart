import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Widgets/mini.dart';

class FormContraintes extends StatelessWidget {
  const FormContraintes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Obx(() =>
        CardForm(
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
            const ButtonAddContrainte()
          ],
        ),
        const Divider(),
        // const SizedBox(height: 15),
      ],
      //   ),
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
                    // VariableNameWidget(
                    //     number: FormController.problemeVariable.length + 1)
                  ],
                ),
              ));

          // if (check != 0) {
          //   FormController.problemeVariable.add(Variable(
          //       name: "x${FormController.problemeVariable.length + 1}",
          //       value: check,
          //       variableType: VariableType.DECISION));
          // }
          //},
        },
      ),
    );
  }
}
