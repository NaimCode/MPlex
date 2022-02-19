import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/Pages/Resolution/controller.dart';
import 'package:mplex/Widgets/mini.dart';
import 'package:provider/provider.dart';

class FormProblemeType extends StatelessWidget {
  const FormProblemeType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormController _ = context.watch<FormController>();
    return Obx(() => CardForm(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choisir le type d'optimisation",
                style: Get.theme.textTheme.subtitle2,
              ),
              const Divider(),
              // const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      child: InkWell(
                          autofocus: true,
                          onTap: () =>
                              _.problemeTypeController.value = ProblemeType.MAX,
                          child: Text(
                            "Maximisation",
                            style: Get.theme.textTheme.bodyText2,
                          )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:
                            _.problemeTypeController.value == ProblemeType.MAX
                                ? Get.theme.scaffoldBackgroundColor
                                : null,
                      )),
                  const SizedBox(width: 10),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      child: InkWell(
                          onTap: () =>
                              _.problemeTypeController.value = ProblemeType.MIN,
                          child: Text(
                            "Minimisation",
                            style: Get.theme.textTheme.bodyText2,
                          )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:
                            _.problemeTypeController.value == ProblemeType.MIN
                                ? Get.theme.scaffoldBackgroundColor
                                : null,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
