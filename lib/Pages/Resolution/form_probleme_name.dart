import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Widgets/mini.dart';

RxBool _problemeHasName = false.obs;

class FormProblemeName extends StatelessWidget {
  const FormProblemeName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardForm(
        widget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Donner un nom au problème",
          style: Get.theme.textTheme.subtitle1,
        ),
        const Divider(),
        const TextField()
      ],
    ));
  }
}
